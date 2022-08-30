import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_management_application/styles/AppColor.dart';

class AppStyle {
  //padding
  static double defaultPadding = 25;

  //formats
  static DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  //headings
  static const mainHeading = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColor.white,
  );
  static const subHeading = TextStyle(
    fontSize: 18,
    color: AppColor.black,
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