import 'package:flutter/material.dart';
import 'package:stem_vault/Core/apptext.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
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
          "Assignments",
          style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20),
        ),
      ),
      body: Center(
        child: Text(
          "View all your pending assignments here",
          style: AppText.mainSubHeadingTextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
