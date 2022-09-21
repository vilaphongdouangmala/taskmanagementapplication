import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:task_management_application/components/LongButton.dart';
import 'package:task_management_application/components/StatusBox.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/models/SubTask.dart';
import 'package:task_management_application/screens/AddAssigneeCard.dart';
import 'package:task_management_application/screens/CreateTaskScreen.dart';

import '../components/AlertPopup.dart';
import '../components/ArrowBackButton.dart';
import '../components/AssigneeListView.dart';
import '../components/FormDatePicker.dart';
import '../components/HeroDialogRoute.dart';
import '../components/InfoBox.dart';
import '../components/ProgressCircle.dart';
import '../components/UnderlineTextBox.dart';
import '../main.dart';
import '../models/Status.dart';
import '../models/Task.dart';
import '../styles/AppColor.dart';
import '../styles/AppStyle.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var store = Provider.of<Store>(context);
    //for status dropdown
    List<String> statusTypes = Status.getStatusTypes();
    Status? selectedStatus = Status.getStatus(task.status);
    String? selectedValue = selectedStatus!.status;
    double taskProgress = store.calTaskProgress(task);
    TextEditingController subTaskNameController = TextEditingController();
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
              height: screenSize.height * 1.15,
              width: screenSize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    task.taskDescription,
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
                height: screenSize.height * 0.85,
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
                            content: task.startDate,
                          ),
                          InfoBox(
                            heading: "Deadline",
                            content: AppStyle.dateFormatter.format(
                              store.calDeadline(task.startDate, task.duration),
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
                      content: "${task.duration} days",
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
                                task.status = value.toString();
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
                            task: task,
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
                        itemCount: task.subTasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          SubTask subTask = task.subTasks[index];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 20),
                            decoration: BoxDecoration(
                              color: subTask.complete
                                  ? AppColor.primaryGreen
                                  : AppColor.primaryYellow,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: CheckboxListTile(
                              side: const BorderSide(
                                color: AppColor.white,
                                width: 3,
                              ),
                              checkColor: AppColor.black,
                              activeColor: AppColor.white,
                              checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: AppStyle.defaultPadding * 0.1),
                              value: subTask.complete,
                              title: Text(
                                subTask.name,
                                style: AppStyle.semiBoldWhiteText,
                              ),
                              subtitle: Text(
                                "Date: ${subTask.datetime}",
                                style: const TextStyle(
                                  color: AppColor.white,
                                ),
                              ),
                              onChanged: (bool? value) {
                                subTask.complete = value!;
                                store.notifyListeners();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            DateTime selectedDate = DateTime.now();
                            DateTime selectedTime = DateTime.now();
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Container(
                                padding:
                                    EdgeInsets.all(AppStyle.defaultPadding),
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                height: screenSize.height * 0.35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom:
                                              AppStyle.defaultPadding * 0.5),
                                      child: const Text(
                                        "Enter the subtask name: ",
                                        style: AppStyle.subHeading_l,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: AppStyle.defaultPadding),
                                      child: UnderlineTextBox(
                                        controller: subTaskNameController,
                                        hintText: 'Subtask Name',
                                        onChange: null,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            DateTime? time = await datePicker(
                                                context, selectedDate);
                                            if (time == null) {
                                              return;
                                            } else if (time
                                                .isBefore(DateTime.now())) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const AlertPopup(
                                                    contentText:
                                                        "The date cannot be before current date.",
                                                  );
                                                },
                                              );
                                            } else {
                                              setState(() {
                                                selectedDate = time;
                                              });
                                            }
                                          },
                                          child: DateTimeBox(
                                            screenSize: screenSize,
                                            icon: const Icon(
                                              Icons.edit_calendar,
                                              color: AppColor.black,
                                            ),
                                            dateTime: AppStyle.dateFormatter
                                                .format(selectedDate),
                                          ),
                                        ),
                                        //timepicker
                                        GestureDetector(
                                          onTap: () {
                                            DatePicker.showTimePicker(
                                              context,
                                              showSecondsColumn: false,
                                              currentTime: selectedTime,
                                              onConfirm: (time) {
                                                setState(() {
                                                  selectedTime = time;
                                                });
                                              },
                                            );
                                          },
                                          child: DateTimeBox(
                                            screenSize: screenSize,
                                            icon: const Icon(
                                              Icons.access_time,
                                            ),
                                            dateTime: AppStyle.timeFormatter
                                                .format(selectedTime),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: AppStyle.defaultPadding),
                                      child: LongButton(
                                        press: () async {
                                          if (subTaskNameController
                                              .text.isNotEmpty) {
                                            SubTask newSubTask = SubTask(
                                              id: task.subTasks.length + 1,
                                              name: subTaskNameController.text,
                                              complete: false,
                                              datetime: AppStyle
                                                  .dateTimeFormatter
                                                  .format(
                                                selectedDate.add(
                                                  Duration(
                                                    hours: selectedTime.hour,
                                                    minutes:
                                                        selectedTime.minute,
                                                  ),
                                                ),
                                              ),
                                            );
                                            task.subTasks.add(newSubTask);
                                            store.update();
                                            //show confirmation dialog
                                            await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: SizedBox(
                                                    height: 85,
                                                    child: Column(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .check_circle_outline_outlined,
                                                          size: 50,
                                                          color: AppColor
                                                              .primaryGreen,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top: AppStyle
                                                                      .defaultPadding *
                                                                  0.5),
                                                          child: const Text(
                                                              "Sucessfully created the subtask"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                            //pop after creating the subtask
                                            Navigator.pop(context);
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const AlertPopup(
                                                  contentText:
                                                      "Please enter the subtask name",
                                                );
                                              },
                                            );
                                          }
                                        },
                                        text: 'Create a new subtask',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: AppStyle.defaultPadding * 0.5),
                        child: const Text("+ Add a new subtask"),
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
} //ec

class DateTimeBox extends StatelessWidget {
  const DateTimeBox({
    Key? key,
    required this.screenSize,
    required this.icon,
    required this.dateTime,
  }) : super(key: key);

  final Size screenSize;
  final Icon icon;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width * 0.375,
      padding: EdgeInsets.symmetric(vertical: AppStyle.defaultPadding * 0.3),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColor.black, width: 0.6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dateTime,
            style: AppStyle.formText,
          ),
          icon,
        ],
      ),
    );
  }
}//ec

