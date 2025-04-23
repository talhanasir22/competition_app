import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Core/appColors.dart';
import '../../Core/apptext.dart';

class SecondPage extends StatefulWidget{
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
                child: Image.asset("assets/Images/Page2.png"),
              ),
            ),
            Center(
              child: Text("Learn, Track & Grow",style: AppText.onboardingHeadingStyle()),
            ),
            Center(
              child: SizedBox(
                height: 30,
                width: 300,
                child: Text("Completeexercises, monitor your progress, and stay motivated with badges, leaderboards, and AI-powered analytics.",
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