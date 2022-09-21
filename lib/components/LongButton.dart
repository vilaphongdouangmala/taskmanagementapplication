import 'package:flutter/material.dart';

import '../styles/AppColor.dart';
import '../styles/AppStyle.dart';

class LongButton extends StatelessWidget {
  final VoidCallback press;
  final String text;

  const LongButton({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: AppColor.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: press,
      child: Text(
        text,
        style: AppStyle.buttonText,
      ),
    );
  }
}//ec
