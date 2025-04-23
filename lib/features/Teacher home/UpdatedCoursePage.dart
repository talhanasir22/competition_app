import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stem_vault/Core/appColors.dart';
import 'package:stem_vault/Core/apptext.dart';
import 'package:stem_vault/Shared/course_annoucement_banner.dart';
import 'package:stem_vault/Shared/LoadingIndicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Data/Firebase/student_services/firestore_services.dart';
import '../../Data/Firebase/student_services/lecture_model.dart';
import 'Home Screens/summary_page.dart';

class UpdateCoursePage extends StatefulWidget {
  final String cid;
  const UpdateCoursePage({Key? key, required this.cid}) : super(key: key);

  @override
  State<UpdateCoursePage> createState() => _UpdateCoursePageState();
}

class _UpdateCoursePageState extends State<UpdateCoursePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    print('Editing course with ID: ${widget.cid}');
  }

  Future<void> _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    } else {
      Fluttertoast.showToast(
        msg: "Only PDF files are allowed.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> _downloadFile(String url, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/$fileName';

      await Dio().download(url, savePath);
      Fluttertoast.showToast(
        msg: "File downloaded successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to download file: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text(
          "Tell us what do you \nwant to teach",
          style: AppText.mainHeadingTextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 6.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CourseAnnouncementBanner(
                  bannerText: "Explore a diverse selection of courses for a comprehensive learning experience.",
                ),
              ),
              const SizedBox(height: 10),
              _buildLabel('My Lectures'),
              SizedBox(
                height: 150,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('lectures')
                      .where('cid', isEqualTo: widget.cid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: LoadingIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No lectures yet'));
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var lecture = snapshot.data!.docs[index];
                        String lectureUrl = lecture['lectureUrl'];

                        return Container(
                          width: 250,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title: ${lecture['lectureTitle']}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Description: ${lecture['lectureDescription']}',
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: (){
                                        print("dub dub dub");
                                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,
                                            child: SummaryPage()
                                        ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.bgColor,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      label: Text(
                                        "Summarize",
                                        style: AppText.buttonTextStyle().copyWith(color: AppColors.theme, fontSize: 14),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () => _downloadFile(lectureUrl, '${lecture['lectureTitle']}.pdf'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.bgColor,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      icon: Icon(Icons.download, color: AppColors.theme, size: 18),
                                      label: Text(
                                        "Download",
                                        style: AppText.buttonTextStyle().copyWith(color: AppColors.theme, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Add new lecture",
                  style: AppText.mainHeadingTextStyle().copyWith(fontSize: 19),
                ),
              ),
              const SizedBox(height: 10),
              _buildLabel('Lecture title'),
              _buildTextField(controller: _titleController),
              _buildLabel("Lecture description"),
              _buildTextField(controller: _descriptionController, maxLines: 3, maxLength: 100),
              _buildLabel("Lecture File"),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickPdfFile,
                child: Row(
                  children: [
                    const Icon(Icons.attach_file, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _selectedFile == null ? "Please select a file" : _selectedFile!.path.split('/').last,
                        style: AppText.hintTextStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _uploadLecture,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgColor,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Upload lecture",
                    style: AppText.buttonTextStyle().copyWith(color: AppColors.theme),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppText.mainSubHeadingTextStyle().copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    int maxLines = 1,
    int maxLength = 20,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          hintText: "Enter here",
          hintStyle: AppText.hintTextStyle(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "This field cannot be empty";
          }
          return null;
        },
      ),
    );
  }

  Future<void> _uploadLecture() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedFile == null) {
        Fluttertoast.showToast(
          msg: "Please select a file.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingIndicator(),
      );

      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final ref = FirebaseStorage.instance.ref().child('lectureFiles/$fileName');
        await ref.putFile(_selectedFile!);
        String downloadUrl = await ref.getDownloadURL();

        String newLectureId = FirebaseFirestore.instance.collection('lectures').doc().id;

        LectureModel lecture = LectureModel(
          cid: widget.cid,
          lid: newLectureId,
          lectureTitle: _titleController.text.trim(),
          lectureDescription: _descriptionController.text.trim(),
          lectureUrl: downloadUrl,
        );

        await FirestoreServices().createLecture(lecture);
        await FirestoreServices().addLecturesToCourse(widget.cid);

        Navigator.pop(context);

        Fluttertoast.showToast(
          msg: "Lecture Created Successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        _titleController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedFile = null;
        });
      } catch (e) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: "Error creating lecture: $e",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }
}