import 'package:flutter/material.dart';
import 'package:stem_vault/Core/apptext.dart';

class SubmissionScreen extends StatefulWidget {
  const SubmissionScreen({super.key});

  @override
  State<SubmissionScreen> createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends State<SubmissionScreen> {
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
          "Submissions",
          style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20),
        ),
      ),
      body: Center(
        child: Text(
          "View all your submissions here",
          style: AppText.mainSubHeadingTextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
