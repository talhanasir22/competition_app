import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stem_vault/Core/apptext.dart';

class AchievementScreen extends StatefulWidget{
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
         Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text("Achievements",style: AppText.mainHeadingTextStyle(),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/Images/no_achievement.png")),
          Center(child: Text("No achievement yet",style: AppText.mainSubHeadingTextStyle()))
        ],
      ),
    );
  }
}