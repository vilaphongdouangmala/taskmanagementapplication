import 'package:flutter/material.dart';

import '../styles/AppColor.dart';

Future<DateTime?> datePicker(BuildContext context, DateTime initialDate) {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1990),
    lastDate: DateTime(2050),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColor.primaryColor,
          ),
        ),
        child: child!,
      );
    },
  );
}
