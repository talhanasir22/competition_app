import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  String summary = '';
  String flashcards = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLectureData();
  }

  Future<void> fetchLectureData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('lectures')
          .doc('your_document_id') // <-- replace this with your document ID
          .get();

      if (doc.exists) {
        setState(() {
          summary = doc['summary'] ?? 'No Summary Available';
          flashcards = doc['flashcards'] ?? 'No Flashcards Available';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching lecture data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
          children: [
            ExpansionTile(
              title: Text(
                'Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    summary,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text(
                'Flash Card',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    flashcards,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
