//===> class: #name#
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_application/components/LongButton.dart';
import 'package:task_management_application/components/StatusBox.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/models/SubTask.dart';
import 'package:task_management_application/screens/AddAssigneeCard.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../components/ArrowBackButton.dart';
import '../components/AssigneeListView.dart';
import '../components/HeroDialogRoute.dart';
import '../components/InfoBox.dart';
import '../components/ProgressCircle.dart';
import '../main.dart';
import '../models/Status.dart';
import '../models/Task.dart';
import '../styles/AppColor.dart';
import '../styles/AppStyle.dart';

class TaskScreen extends StatefulWidget {
  Task task;
  TaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var store = Provider.of<Store>(context);
    //for status dropdown
    List<String> statusTypes = Status.getStatusTypes();
    Status? selectedStatus = Status.getStatus(widget.task.status);
    String? selectedValue = selectedStatus!.status;
    double taskProgress = store.calTaskProgress(widget.task);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.08,
                left: AppStyle.defaultPadding,
                right: AppStyle.defaultPadding,
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
                    children: [
                      const ArrowBackButton(),
                      StatusBox(task: widget.task),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      widget.task.taskName,
                      style: AppStyle.mainHeading,
                    ),
                  ),
                  Text(
                    widget.task.taskDescription,
                    style: const TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.04,
                  horizontal: AppStyle.defaultPadding,
                ),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                height: screenSize.height * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Start Date and Deadline
                    SizedBox(
                      // width: screenSize.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoBox(
                            heading: "Start Date",
                            content: widget.task.startDate,
                          ),
                          InfoBox(
                            heading: "Deadline",
                            content: AppStyle.dateFormatter.format(
                              store.calDeadline(
                                  widget.task.startDate, widget.task.duration),
                            ),
                          ),
                          ProgressCircle(
                            taskProgress: taskProgress,
                            radius: 40,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                    //Duration
                    InfoBox(
                      heading: "Duration",
                      content: "${widget.task.duration} days",
                    ),
                    //Status
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: AppStyle.defaultPadding * 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Status",
                            style: AppStyle.subHeading_l,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              value: selectedValue,
                              items: statusTypes
                                  .map(
                                    (status) => DropdownMenuItem<String>(
                                      value: status,
                                      child: Text(status),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                widget.task.status = value.toString();
                                store.notifyListeners();
                              },
                              buttonHeight: 40,
                              buttonWidth: 140,
                              itemHeight: 40,
                              selectedItemHighlightColor: selectedStatus.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Assignees
                    Padding(
                      padding: EdgeInsets.only(bottom: AppStyle.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: AppStyle.defaultPadding * 0.5),
                            child: const Text(
                              "Assignees",
                              style: AppStyle.subHeading_l,
                            ),
                          ),
                          AssigneeListView(
                            task: widget.task,
                          ),
                        ],
                      ),
                    ),
                    //subTasks
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: AppStyle.defaultPadding * 0.7),
                      child: const Text(
                        "Subtasks",
                        style: AppStyle.subHeading_l,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, indext) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: widget.task.subTasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          SubTask subTask = widget.task.subTasks[index];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding:
                                EdgeInsets.all(AppStyle.defaultPadding * 0.5),
                            decoration: BoxDecoration(
                              color: subTask.complete
                                  ? Color.fromARGB(255, 203, 237, 172)
                                  : AppColor.grey,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: AppStyle.defaultPadding * 0.1),
                              value: subTask.complete,
                              title: Text(subTask.name),
                              onChanged: (bool? value) {
                                subTask.complete = value!;
                                store.notifyListeners();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } //ef
}//ec

