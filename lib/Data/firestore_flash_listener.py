from fastapi import FastAPI
from contextlib import asynccontextmanager
import google.generativeai as genai
import firebase_admin
from firebase_admin import credentials, firestore
import asyncio
import pdfplumber
import pytesseract
from PIL import Image
import requests
import json
import re
from io import BytesIO
from dotenv import load_dotenv
import os
from urllib.parse import quote

# Load environment variables
load_dotenv()

# Initialize Firebase Admin
firebase_cred_path = os.getenv("FIREBASE_CRED_PATH")
if not firebase_cred_path:
    raise ValueError("FIREBASE_CRED_PATH environment variable is not set")
cred = credentials.Certificate(firebase_cred_path)
firebase_admin.initialize_app(cred)
db = firestore.client()
print("[INFO] Firebase initialized successfully.")

# Initialize Gemini API
gemini_api_key = os.getenv("GEMINI_API_KEY")
if not gemini_api_key:
    raise ValueError("GEMINI_API_KEY environment variable is not set")
genai.configure(api_key=gemini_api_key)
model = genai.GenerativeModel("models/gemini-2.0-flash")
print("[INFO] Gemini API initialized successfully.")

app = FastAPI()

async def extract_content_from_firebase(file_path: str) -> str:
    """Extract text content from a file path in Firebase Storage."""
    if not file_path:
        return ""

    try:
        base_url = "https://firebasestorage.googleapis.com/v0/b/stem-vault.firebasestorage.app/o/"
        full_url = f"{base_url}{quote(file_path, safe='')}?alt=media"
        response = requests.get(full_url)
        response.raise_for_status()
        content = response.content

        if file_path.lower().endswith('.pdf'):
            with pdfplumber.open(BytesIO(content)) as pdf:
                return "\n".join(page.extract_text() or "" for page in pdf.pages).strip()
        elif file_path.lower().endswith(('.png', '.jpg', '.jpeg', '.bmp', '.tiff')):
            img = Image.open(BytesIO(content))
            return pytesseract.image_to_string(img).strip()
        else:
            print(f"[WARNING] Unsupported file type for Firebase file: {file_path}")
            return ""
    except Exception as e:
        print(f"[ERROR] Failed to extract content from {file_path}: {e}")
        return ""

async def generate_summary_and_flashcards(lecture_data: dict, url_content: str) -> tuple:
    """Generate summary and structured flashcards using Gemini API."""
    # Filter lecture data for prompt
    filtered_data = {k: v for k, v in lecture_data.items() if k not in ['cid', 'lid', 'lectureUrl']}
    lecture_json = json.dumps(filtered_data, indent=2)
    combined_content = f"Lecture Data (JSON):\n{lecture_json}\n\nExtracted Content:\n{url_content}"

    # Generate summary
    summary_prompt = f"Summarize the following lecture content:\n{combined_content}"
    summary_resp = model.generate_content(summary_prompt)
    summary = summary_resp.text

    # Generate flashcards as JSON
    flashcard_prompt = (
        "Generate flashcards as a JSON array of objects, each with `q` (question) and `a` (answer) fields, you are to answer only in the json format provided and nothing else not even a thought"
        " based on the following lecture content:\n" + combined_content
    )
    flashcard_resp = model.generate_content(flashcard_prompt)
    raw = flashcard_resp.text

    # Clean and validate JSON format using regex if needed
    try:
        # Extract all pairs that look like flashcards
        matches = re.findall(r'\{\s*"q":\s*"(.*?)",\s*"a":\s*"(.*?)"\s*\}', raw, re.DOTALL)
        if matches:
            flashcards_list = [{"q": q.strip(), "a": a.strip()} for q, a in matches]
        else:
            # Try to parse as normal JSON if regex fails
            flashcards_list = json.loads(raw)
            if not isinstance(flashcards_list, list) or not all(isinstance(item, dict) and 'q' in item and 'a' in item for item in flashcards_list):
                raise ValueError("Invalid flashcards format")
    except Exception:
        flashcards_list = [{"q": "Lecture flashcards", "a": raw}]

    return summary, flashcards_list

async def process_lecture(lecture_id: str, lecture_data: dict):
    """Process a single lecture: extract content, generate summary & flashcards if needed."""
    print(f"[INFO] Processing lecture '{lecture_id}'")
    summary = lecture_data.get('summary', '')
    flashcards = lecture_data.get('flashcards', '')
    if summary and flashcards:
        print(f"[INFO] Already processed, skipping {lecture_id}")
        return

    firebase_path = lecture_data.get('firebasePath', '')
    content = await extract_content_from_firebase(firebase_path)

    try:
        summary, flashcards = await generate_summary_and_flashcards(lecture_data, content)
    except Exception as e:
        print(f"[ERROR] Generation failed for {lecture_id}: {e}")
        return

    update = {}
    if not lecture_data.get('summary'):
        update['summary'] = summary
    if not lecture_data.get('flashcards'):
        update['flashcards'] = flashcards

    try:
        db.collection("lectures").document(lecture_id).set(update, merge=True)
        print(f"[INFO] Updated lecture '{lecture_id}'")
    except Exception as e:
        print(f"[ERROR] Firestore update failed for {lecture_id}: {e}")

async def process_all_lectures():
    """Fetch and process all lectures in the top-level collection."""
    print("[INFO] Fetching all lectures...")
    try:
        lectures = db.collection("lectures").get()
        if not lectures:
            print("[INFO] No lectures found.")
            return

        print(f"[INFO] Found {len(lectures)} lectures.")
        await asyncio.gather(*[
            process_lecture(doc.id, doc.to_dict())
            for doc in lectures
        ])
    except Exception as e:
        print(f"[ERROR] Failed to fetch/process lectures: {e}")

@asynccontextmanager
async def lifespan(app: FastAPI):
    print("[INFO] FastAPI lifespan startup: processing lectures")
    await process_all_lectures()
    yield
    print("[INFO] FastAPI shutting down.")

app.lifespan = lifespan

@app.get("/process-lectures")
async def trigger_processing():
    """Manual trigger for processing all lectures."""
    await process_all_lectures()
    return {"status": "Lectures processing triggered"}

@app.get("/health")
async def health_check():
    return {"status": "ok"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, log_level="info")
