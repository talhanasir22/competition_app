import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Core/appColors.dart';
import '../Core/apptext.dart';

class CourseAnnouncementBanner extends StatelessWidget{
  final String bannerText;
  const CourseAnnouncementBanner({super.key, required this.bannerText});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0,top: 25),
              child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Text( bannerText
                    ,style: AppText.mainSubHeadingTextStyle().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600
                    ),)),
            ),
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: AppColors.theme.withOpacity(0.56),
                    shape: BoxShape.circle
                ),
                child: Center(
                  child:  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        color: AppColors.theme.withOpacity(0.8),
                        shape: BoxShape.circle
                    ),
                    child:   Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColors.theme.withOpacity(1),
                            shape: BoxShape.circle
                        ),
                        child: Center(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.theme,
                              backgroundImage: AssetImage("assets/Images/Logo.png"),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}