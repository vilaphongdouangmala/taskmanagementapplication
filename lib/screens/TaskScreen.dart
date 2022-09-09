//===> class: #name#
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_application/components/LongButton.dart';
import 'package:task_management_application/components/StatusBox.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/screens/AddAssigneeCard.dart';

import '../components/ArrowBackButton.dart';
import '../components/AssigneeListView.dart';
import '../components/HeroDialogRoute.dart';
import '../components/InfoBox.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
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
                  vertical: screenSize.height * 0.08,
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
                      width: screenSize.width * 0.5,
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
                    Column(
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}//ec