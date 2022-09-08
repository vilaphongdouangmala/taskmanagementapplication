import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_management_application/styles/AppColor.dart';

class AppStyle {
  //padding
  static double defaultPadding = 25;

  //main formats
  static DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  static const pagePopText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColor.primaryColor,
  );

  //headings
  static const mainHeading = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColor.white,
  );

  static const mainHeadingBlack = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColor.black,
  );

  static const subHeading_l = TextStyle(
    fontSize: 18,
    color: AppColor.black,
  );
  static const subHeading_b = TextStyle(
    fontSize: 18,
    color: AppColor.black,
    fontWeight: FontWeight.bold,
  );

  //mainpage
  static const mainTaskStatus = TextStyle(
    color: AppColor.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  //create task screen
  static const formText = TextStyle(
    fontSize: 18,
    color: AppColor.black,
  );
  static const buttonText = TextStyle(
    fontSize: 18,
    color: AppColor.white,
  );

  //task screen
  static const taskStatus = TextStyle(
    fontWeight: FontWeight.bold,
  );
}//ec