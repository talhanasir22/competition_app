import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stem_vault/Core/appColors.dart';
import 'package:stem_vault/Core/apptext.dart';
import 'package:stem_vault/Shared/course_annoucement_banner.dart';

class SetAssignment extends StatefulWidget {
  @override
  _SetAssignmentState createState() => _SetAssignmentState();
}

class _SetAssignmentState extends State<SetAssignment> {
  final List<String> courseTitles = [
    "Game Development",
    "Flutter Basics",
    "Web Development",
    "Machine Learning",
    "Data Science"
  ];

  String? selectedCourse;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Set Assignment", style: AppText.mainHeadingTextStyle()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CourseAnnouncementBanner(
                bannerText: "Assign subject-relevant tasks to your students effectively.",
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: AppColors.theme,
              elevation: 12,
              margin: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select your subject", style: AppText.descriptionTextStyle()),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedCourse,
                      hint: Text("Choose a subject"),
                      items: courseTitles.map((String course) {
                        return DropdownMenuItem<String>(
                          value: course,
                          child: Text(course),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCourse = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Select due Date and time", style: AppText.descriptionTextStyle()),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickDate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: selectedDate != null
                                      ? DateFormat.yMMMd().format(selectedDate!)
                                      : "Select Date",
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickTime(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: selectedTime != null
                                      ? selectedTime!.format(context)
                                      : "Select Time",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text("Upload Assignment", style: AppText.descriptionTextStyle().copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.attach_file),
                        label: Text("Attach File", style: AppText.hintTextStyle()),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.theme),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),

                    SizedBox(height: 80),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bgColor,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Confirm & Upload",style: AppText.buttonTextStyle().copyWith(
                            color: AppColors.theme,
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
