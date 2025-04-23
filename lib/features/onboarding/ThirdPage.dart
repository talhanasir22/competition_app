import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Core/appColors.dart';
import '../../Core/apptext.dart';

class ThirdPage extends StatefulWidget{
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.theme,
        body: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .35,
                width: MediaQuery.of(context).size.height * .75,
                child: Image.asset("assets/Images/Page3.png"),
              ),
            ),
            Center(
              child: Text("Stay on Track",style: AppText.onboardingHeadingStyle()),
            ),
            Center(
              child: SizedBox(
                height: 30,
                width: 300,
                child: Text("Never miss a deadline with assignment reminders, personalized feedback, and learning milestones.",
                  overflow: TextOverflow.visible,
                  maxLines: 5, // Limits text to 2 lines
                  textAlign: TextAlign.center, // Centers text
                  style: AppText.onboardingDescStyle(),
                ),
              ),

            )
          ],
        )
    );
  }
}