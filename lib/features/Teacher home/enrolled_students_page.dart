import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stem_vault/Core/apptext.dart';
import 'package:stem_vault/Shared/course_annoucement_banner.dart';
import '../../Core/appColors.dart';

class EnrolledStudentPage extends StatefulWidget {
  const EnrolledStudentPage({super.key});

  @override
  State<EnrolledStudentPage> createState() => _EnrolledStudentPageState();
}

class _EnrolledStudentPageState extends State<EnrolledStudentPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  List<String> studentNames = [
    "John Doe",
    "Emma Smith",
    "Michael Brown",
    "Sophia Johnson",
    "John Doe",
    "Emma Smith",
    "Michael Brown",
    "Sophia Johnson",
    "John Doe",
    "Emma Smith",
    "Michael Brown",
    "Sophia Johnson"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            "Student Performance\nAnalytics",
            style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20),
          ),
        ),
      ),
      body: _isLoading ? _buildShimmerEffect() : _buildContent(),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          CourseAnnouncementBanner(
              bannerText:
              "Manage students, track individual performance, and review assignments seamlessly."),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Click to view each student's performance in detail.",
              style: AppText.mainSubHeadingTextStyle(),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Enrolled Students",
                  style: AppText.descriptionTextStyle()
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.bgColor,
                child: Text(studentNames.length.toString()),
              )
            ],
          ),
          SizedBox(
            height: 400,
            child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: studentNames.length,
                itemBuilder: (context, index) {
                  return _buildElevatedButton(studentNames[index], () {});
                }),
          )
        ],
      ),
    );
  }

  Widget _buildElevatedButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: AppText.mainSubHeadingTextStyle().copyWith(
                    fontSize: 16,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            )),
      ),
    );
  }
}
