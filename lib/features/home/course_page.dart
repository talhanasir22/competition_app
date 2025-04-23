import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stem_vault/Core/appColors.dart';
import 'package:stem_vault/Core/apptext.dart';
import 'package:stem_vault/Shared/course_annoucement_banner.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with SingleTickerProviderStateMixin {
  String? selectedCategory;
  String? selectedDuration;
  late TabController _tabController;

  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.amber,
    Colors.indigo,
    Colors.cyan,
    Colors.brown,
  ];
  final List<String> categories = [
    "SCIENCE",
    "TECHNOLOGY",
    "ENGINEERING",
    "MATHEMATICS"
  ];

// 10 STEM-related courses
  List<String> courses = [
    "Game Development",
    "3D Animation",
    "Machine Learning",
    "Data Science",
    "Cybersecurity",
    "Artificial Intelligence",
    "Cloud Computing",
    "Robotics",
    "Mobile App Development",
    "Web Development",
  ];

// 10 Instructor Names
  List<String> instructors = [
    "Dr. Alan Smith",
    "Prof. Emily Johnson",
    "Michael Brown",
    "Sarah Williams",
    "David Lee",
    "Jessica Taylor",
    "John Carter",
    "Sophia Anderson",
    "James Wilson",
    "Olivia Martinez",
  ];


  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder( // Maintains state when reopened
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Search Filter",
                        style: AppText.mainHeadingTextStyle().copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 22
                        )
                            .copyWith(color: AppColors.theme),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Categories",
                      style: AppText.mainHeadingTextStyle().copyWith(
                        color: AppColors.theme,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: categories.map((category) {
                        bool isSelected = category == selectedCategory;
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedCategory =
                              isSelected ? null : category;
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.bgColor),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color:
                                isSelected ? AppColors.bgColor : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the modal
                            },
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                width: 1
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              backgroundColor: AppColors.bgColor,
                            ),
                            child: Text("Clear",
                            style: TextStyle(color: Colors.black),),
                          ),
                        ),
                        SizedBox(width: 20,),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the modal
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text("Apply Filter",
                            style: TextStyle(color: AppColors.bgColor),),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Choose Your Course",
          style: AppText.mainHeadingTextStyle(),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              height: 40,
              child: TextField(
                style: TextStyle(fontSize: 14),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  hintText: "Find Course",
                  hintStyle: AppText.hintTextStyle(),
                  prefixIcon: Icon(Icons.search, color: AppColors.hintIconColor),
                  suffixIcon: IconButton(
                    onPressed: _showFilterBottomSheet,
                    icon: Icon(Icons.tune_rounded, color: AppColors.hintIconColor),
                  ),
                  filled: true,
                  fillColor: AppColors.textFieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
         CourseAnnouncementBanner(bannerText: "Explore a diverse selection ofcourses for a comprehensive learning experience.",),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10), // Added bottom padding
            child: SizedBox(
              height: 30, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Total number of tabs
                itemBuilder: (context, index) {
                  List<String> tabTitles = [
                    "All",
                    "Science",
                    "Technology",
                    "Engineering",
                    "Mathematics"
                  ];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: 1,
                      left: index == 0 ? 16 : 8,
                      right: 8,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _tabController.animateTo(index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _tabController.index == index
                            ? Colors.black
                            : Colors.white,
                        foregroundColor:
                        _tabController.index == index ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(tabTitles[index]),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 15,),
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 1500)), // Simulated delay
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 100,
                        child: Card(
                          elevation: 1,
                          shadowColor: Colors.grey,
                          child: ListTile(
                            leading: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 80,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white, // Placeholder color
                                ),
                              ),
                            ),
                            title: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 10,
                                width: 100,
                                color: Colors.white, // Placeholder
                              ),
                            ),
                            subtitle: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white, // Placeholder
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    height: 10,
                                    width: 40,
                                    color: Colors.white, // Placeholder
                                  ),
                                ],
                              ),
                            ),
                            trailing: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 30,
                                width: 95,
                                color: Colors.white, // Placeholder
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 50,
                      height: 100,
                      child: Card(
                        color: AppColors.theme,
                        elevation: 1,
                        shadowColor: Colors.grey,
                        child: ListTile(
                          leading: Container(
                            height: 80,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colors[index],
                            ),
                          ),
                          title: Text(
                            courses[index],
                            style: AppText.mainSubHeadingTextStyle().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  instructors[index],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            height: 30,
                            width: 95,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.bgColor,
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                "Enroll Now",
                                style: AppText.buttonTextStyle().copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),



    ],
      ),
    );
  }
}
