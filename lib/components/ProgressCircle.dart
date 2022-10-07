import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../styles/AppColor.dart';

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({
    Key? key,
    required this.taskProgress,
    required this.radius,
    required this.fontSize,
  }) : super(key: key);

  final double taskProgress;
  final double radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      animation: true,
      animateFromLastPercent: true,
      animationDuration: 600,
      radius: radius,
      lineWidth: radius / 4,
      percent: taskProgress,
      progressColor:
          taskProgress == 1 ? AppColor.primaryGreen : AppColor.primaryColor,
      backgroundColor: AppColor.grey,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        "${(taskProgress * 100).toInt()}%",
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  } //ef
}//ec