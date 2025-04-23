import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stem_vault/Core/apptext.dart';
import '../../../Core/appColors.dart';

class MyCourse extends StatefulWidget {
  const MyCourse({super.key});

  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  bool isLoading = true; // Control shimmer loading state

  List<String> courseTitles = [
    "Game Development",
    "Flutter Basics",
    "Web Development",
    "Machine Learning",
    "Data Science"
  ];

  List<Color> cardColors = [
    Colors.blue.shade400,
    Colors.green.shade400,
    Colors.purple.shade400,
    Colors.orange.shade400,
    Colors.red.shade400,
  ];

  List<double> progressValues = [0.6, 1.0, 0.4, 0.7, 0.5];
  List<String> progressText = ["14/60", "48/60", "10/60", "60/60", "30/60"];

  @override
  void initState() {
    super.initState();
    // Simulate a network delay for shimmer effect
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
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
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "My Courses",
          style: AppText.mainHeadingTextStyle(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          /// First Container (Shimmer Effect Applied)
          Center(
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.theme,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: isLoading
                  ? _buildShimmerFirstContainer()
                  : _buildFirstContainerContent(),
            ),
          ),

          const SizedBox(height: 20),

          /// GridView (Shimmer Applied)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return isLoading
                      ? _buildShimmerGridItem()
                      : _buildGridItem(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Shimmer Effect for First Container**
  Widget _buildShimmerFirstContainer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 15, width: 100, color: Colors.white),
          const SizedBox(height: 5),
          Container(height: 20, width: 80, color: Colors.white),
          const SizedBox(height: 5),
          Container(height: 8, width: double.infinity, color: Colors.white),
        ],
      ),
    );
  }

  /// **Actual Content for First Container**
  Widget _buildFirstContainerContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Learned Today", style: AppText.hintTextStyle()),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: "35",
            style: AppText.mainHeadingTextStyle(),
            children: [
              TextSpan(
                text: "/60min",
                style: AppText.hintTextStyle(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: 0.6,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
      ],
    );
  }

  /// **Shimmer Effect for Grid Items**
  Widget _buildShimmerGridItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 20, width: 120, color: Colors.white),
              Container(height: 8, width: double.infinity, color: Colors.white),
              Container(height: 15, width: 80, color: Colors.white),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 20, width: 50, color: Colors.white),
                  Icon(Icons.play_circle, size: 40, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Actual Grid Items**
  Widget _buildGridItem(int index) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      color: cardColors[index],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseTitles[index],
              style: AppText.mainHeadingTextStyle().copyWith(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            LinearProgressIndicator(
              value: progressValues[index],
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            Text(
              "Completed",
              style: AppText.mainSubHeadingTextStyle().copyWith(
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  progressText[index],
                  style: AppText.mainSubHeadingTextStyle().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_circle, color: Colors.white, size: 40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
