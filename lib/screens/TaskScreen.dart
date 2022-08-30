//===> class: #name#
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_application/components/StatusBox.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

import '../components/ArrowBackButton.dart';
import '../main.dart';
import '../models/Task.dart';
import '../styles/AppColor.dart';
import '../styles/AppStyle.dart';

class TaskScreen extends StatelessWidget {
  Task task;
  TaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var store = Provider.of<Store>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.08,
          horizontal: AppStyle.defaultPadding,
        ),
        decoration: const BoxDecoration(
          color: AppColor.primaryColor,
        ),
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const ArrowBackButton(),
                StatusBox(task: task),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                task.taskName,
                style: AppStyle.mainHeading,
              ),
            ),
            TextDropdownFormField(
              options: ["Male", "Female"],
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
                suffixIcon: Icon(Icons.arrow_drop_down),
                labelText: "Gender",
                fillColor: Colors.white,
                focusColor: Colors.white,
                iconColor: Colors.white,
              ),
              dropdownHeight: 120,
            ),
          ],
        ),
      ),
    );
  } //ef
}//ec