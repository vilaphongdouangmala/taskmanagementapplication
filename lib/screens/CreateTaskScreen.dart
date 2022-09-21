//===> class: #name#
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_application/components/AssigneeListView.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/models/SubTask.dart';

import 'package:task_management_application/styles/AppColor.dart';
import 'package:task_management_application/styles/AppStyle.dart';

import '../components/AlertPopup.dart';
import '../components/ArrowBackButton.dart';
import '../components/FormDatePicker.dart';
import '../components/LongButton.dart';
import '../components/UnderlineTextBox.dart';
import '../main.dart';
import '../models/Task.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late Store store;

  //controllers
  TextEditingController taskNameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  //date
  DateTime startDate = DateTime.now();
  DateTime deadline = DateTime.now();

  //list
  List<Employee> initialAssignees = [];
  List<SubTask> subTasks = [];

  //task
  Task creatingTask = Task(
    id: 0,
    taskName: "taskName",
    taskDescription: "taskDescription",
    status: "status",
    startDate: "startDate",
    duration: 0,
    assignedPeople: [],
    subTasks: [],
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    store = Provider.of<Store>(context);
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
                        "Create a New Task",
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
                        padding:
                            EdgeInsets.only(bottom: AppStyle.defaultPadding),
                        child: UnderlineTextBox(
                          controller: taskNameController,
                          hintText: 'Task Name',
                          onChange: null,
                        ),
                      ),

                      //task description
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: AppStyle.defaultPadding),
                        child: TextField(
                          maxLength: 256,
                          maxLines: 6,
                          controller: taskDescriptionController,
                          style: TextStyle(color: Colors.grey[800]),
                          onChanged: (String text) {},
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),

                      //startdate and duration
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: AppStyle.defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //start date and duration
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Start Date",
                                  style: AppStyle.subHeading_l,
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
                                                "The start date cannot be after deadline.",
                                          );
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
                            //duration
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Duration",
                                    style: AppStyle.subHeading_l,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: screenSize.width * 0.3,
                                      height: 40,
                                      child: TextField(
                                        controller: durationController,
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                        onChanged: (String text) {},
                                        decoration: const InputDecoration(),
                                      ),
                                    ),
                                    const Text(
                                      "Days",
                                      style: AppStyle.subHeading_l,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: AppStyle.defaultPadding * 1.7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: AppStyle.defaultPadding * 0.5),
                              child: const Text(
                                "Assign Employees",
                                style: AppStyle.subHeading_l,
                              ),
                            ),
                            AssigneeListView(
                              task: creatingTask,
                            ),
                          ],
                        ),
                      ),
                      //create button
                      LongButton(
                        text: "Create New Task",
                        press: () async {
                          //set task information
                          creatingTask.id = store.tasks.length;
                          creatingTask.taskName = taskNameController.text;
                          creatingTask.taskDescription =
                              taskDescriptionController.text;
                          creatingTask.status = "Not Started";
                          creatingTask.startDate =
                              AppStyle.dateFormatter.format(startDate);
                          creatingTask.duration =
                              int.parse(durationController.text);
                          //assigned people are set in listview

                          //add task
                          store.setNewTask(creatingTask);

                          //confirmation popup
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertPopup(
                                contentText: "The task is successfully created",
                              );
                            },
                          );
                          //pop the screen after creating
                          Navigator.pop(context);
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
