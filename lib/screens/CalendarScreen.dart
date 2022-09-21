// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/models/SubTask.dart';
import 'package:task_management_application/models/Task.dart';
import 'package:task_management_application/screens/TaskScreen.dart';
import 'package:task_management_application/styles/AppStyle.dart';

import '../components/BottomNav.dart';
import '../components/StatusBox.dart';
import '../main.dart';
import '/styles/AppColor.dart';
import 'CreateTaskScreen.dart';

class CaldendarScreen extends StatelessWidget {
  bool first = true;

  @override
  Widget build(BuildContext context) {
    //store reference
    var store = Provider.of<Store>(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //body
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenSize.height * 0.18),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppStyle.defaultPadding),
                  child: DatePicker(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day - 5,
                    ),
                    initialSelectedDate: DateTime.now(),
                    daysCount: 31,
                    selectionColor: AppColor.primaryColor,
                    onDateChange: (date) {
                      store.setSelectedDate(date);
                    },
                  ),
                ),
                Expanded(
                  child: store.subtasks.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: AppStyle.defaultPadding * 0.5),
                              child: const Text(
                                "No Activities For Today",
                                style: AppStyle.mainHeadingBlack,
                              ),
                            ),
                            const Icon(
                              Icons.celebration,
                              size: 60,
                              color: AppColor.primaryColor,
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: store.subtasks.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text(store.subtasks[index].name),
                              subtitle: Text(store.subtasks[index].datetime),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          Container(
            height: screenSize.height * 0.18,
            width: screenSize.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: AppColor.primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(AppStyle.defaultPadding,
                  AppStyle.defaultPadding * 1.5, AppStyle.defaultPadding, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Today's Activities",
                    style: AppStyle.mainHeading,
                  ),
                  Icon(
                    Icons.account_circle,
                    size: 50,
                    color: AppColor.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  } //ef
}
