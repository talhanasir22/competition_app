import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appColors.dart';

class AppText{


  static TextStyle onboardingHeadingStyle(){
    return GoogleFonts.inter(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.w800,
    );
  }
  static TextStyle onboardingDescStyle(){
    return GoogleFonts.inter(
      fontSize: 14,
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    );
  }
  static TextStyle descriptionTextStyle(){
    return GoogleFonts.inter(
      fontSize: 16,
      color: Color(0xff000000),
      fontWeight: FontWeight.w400,
    );
  }


  static TextStyle authHeadingStyle(){
    return GoogleFonts.inter(
      fontSize: 25,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
  }
  static TextStyle hintTextStyle(){
    return GoogleFonts.inter(
      fontSize: 12,
      color: Color(0xff828282),
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle buttonTextStyle(){
    return GoogleFonts.inter(
      fontSize: 14,
      color: Color(0xffFFFFFF),
      fontWeight: FontWeight.w900,
    );
  }
  static TextStyle navSelectedLabelTextStyle(){
    return GoogleFonts.montserrat(
      fontSize: 11,
      color: AppColors.bgColor,
    );
  }
  static TextStyle navUnSelectedLabelTextStyle(){
    return GoogleFonts.montserrat(
      fontSize: 10,
      color: Colors.grey,
      fontWeight: FontWeight.w400
    );
  }
  static TextStyle mainHeadingTextStyle(){
    return GoogleFonts.poppins(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.w600
    );
  }
  static TextStyle mainSubHeadingTextStyle(){
    return GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.normal
    );
  }
}