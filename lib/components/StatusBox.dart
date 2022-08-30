import 'package:flutter/material.dart';
import 'package:task_management_application/models/Status.dart';

import '../main.dart';
import '../models/Task.dart';
import '../styles/AppStyle.dart';

class StatusBox extends StatelessWidget {
  Task task;

  StatusBox({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppStyle.defaultPadding * 0.5),
      decoration: BoxDecoration(
        color: Status.getStatus(task.status)!.color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        task.status,
        style: AppStyle.taskStatus,
      ),
    );
  }
}
