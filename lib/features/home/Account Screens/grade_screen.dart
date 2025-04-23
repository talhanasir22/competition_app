import 'package:flutter/material.dart';
import 'package:stem_vault/Core/apptext.dart';

class GradeScreen extends StatefulWidget {
  const GradeScreen({super.key});

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
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
          "Grades",
          style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20),
        ),
      ),
      body: Center(
        child: Text(
          "View all your grades here",
          style: AppText.mainSubHeadingTextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
