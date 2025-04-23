import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stem_vault/Core/appColors.dart';

import '../../Core/apptext.dart';

class FirstPage extends StatefulWidget{
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
                child: Image.asset("assets/Images/Logo.png"),
            ),
          ),
          Center(
            child: Text("Welcome to EdTech!",style: AppText.onboardingHeadingStyle()),
          ),
          Center(
              child: SizedBox(
                height: 30,
                width: 300,
                child: Text(
                  "Unlock the power of learning with interactive AI-driven insights, and gamified progress tracking.",
                  overflow: TextOverflow.visible,
                  maxLines: 5,
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