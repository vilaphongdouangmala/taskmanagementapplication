//===> class: #name#
import 'package:flutter/material.dart';

import '../models/Task.dart';

class TaskScreen extends StatelessWidget {
  Task task;
  TaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          task.taskName,
        ),
      ),
    );
  } //ef
}//ec