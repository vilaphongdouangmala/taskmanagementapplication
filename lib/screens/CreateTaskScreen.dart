//===> class: #name#
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_management_application/styles/AppColor.dart';
import 'package:task_management_application/styles/AppStyle.dart';

import '../components/AlertPopup.dart';
import '../components/ArrowBackButton.dart';
import '../components/FormDatePicker.dart';
import '../components/LongButton.dart';
import '../main.dart';
import '../models/Task.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  //controllers
  TextEditingController taskName = TextEditingController();

  //date
  DateTime startDate = DateTime.now();
  DateTime deadline = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var store = Provider.of<Store>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          //unfocused on tap
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          } //eif
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
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
                        const Icon(
                          Icons.account_circle,
                          color: AppColor.white,
                          size: 35,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Create Task",
                        style: AppStyle.mainHeading,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(AppStyle.defaultPadding * 1.2),
                  height: screenSize.height * 0.8,
                  width: screenSize.width,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //task name
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: AppStyle.defaultPadding * 1.7),
                        child: TextField(
                          controller: taskName,
                          style: TextStyle(color: Colors.grey[800]),
                          onChanged: (String text) {},
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Task Name',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //start date
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: AppStyle.defaultPadding * 1.7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Start Date",
                                  style: AppStyle.subHeading,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? setStartDate = await datePicker(
                                      context,
                                      startDate,
                                    );
                                    if (setStartDate == null) {
                                      //if user presses cancel, then return null
                                      return;
                                    } else if (setStartDate.isAfter(deadline)) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertPopup(
                                              contentText:
                                                  "The start date cannot be after deadline.");
                                        },
                                      );
                                      return;
                                    } else {
                                      setState(() {
                                        startDate = setStartDate;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: screenSize.width * 0.375,
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            AppStyle.defaultPadding * 0.5),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: AppColor.black, width: 0.6),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${startDate.year}-${startDate.month}-${startDate.day}",
                                          style: AppStyle.formText,
                                        ),
                                        const Icon(
                                          Icons.edit_calendar,
                                          color: AppColor.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Deadline
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: AppStyle.defaultPadding * 1.7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Deadline",
                                  style: AppStyle.subHeading,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? setDeadline = await datePicker(
                                      context,
                                      deadline,
                                    );
                                    if (setDeadline == null) {
                                      //if user presses cancel, then return null
                                      return;
                                    } else if (setDeadline
                                        .isBefore(startDate)) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertPopup(
                                            contentText:
                                                "The deadline cannot be before start date.",
                                          );
                                        },
                                      );
                                      return;
                                    } else {
                                      setState(() {
                                        deadline = setDeadline;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: screenSize.width * 0.375,
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            AppStyle.defaultPadding * 0.5),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: AppColor.black, width: 0.6),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${deadline.year}-${deadline.month}-${deadline.day}",
                                          style: AppStyle.formText,
                                        ),
                                        const Icon(
                                          Icons.edit_calendar,
                                          color: AppColor.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //create button
                      LongButton(
                        text: "Create New Task",
                        press: () {
                          store.createNewTask(
                            taskName.text,
                            AppStyle.dateFormatter.format(startDate).toString(),
                            AppStyle.dateFormatter.format(deadline).toString(),
                          );
                          //popup
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertPopup(
                                contentText: "The task is successfully created",
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } //ef

}