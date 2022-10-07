//===> class: HomePage2
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_application/models/Status.dart';
import 'package:task_management_application/screens/TaskScreen.dart';
import 'package:task_management_application/styles/AppColor.dart';
import 'package:task_management_application/styles/AppStyle.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../components/ProgressCircle.dart';
import '../main.dart';
import '../models/Employee.dart';
import '../models/Task.dart';
import 'CreateTaskScreen.dart';

class HomeScreen extends StatelessWidget {
  List<String> statusTypes = Status.getStatusTypes();
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenScreen = MediaQuery.of(context).size;
    var store = Provider.of<Store>(context);
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          //main body
          Container(
            padding: EdgeInsets.only(top: AppStyle.defaultPadding * 9),
            width: screenScreen.width,
            height: screenScreen.height * 1.25,
            decoration: const BoxDecoration(
              color: AppColor.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(AppStyle.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.1),
                    child: const Text(
                      "Progress",
                      style: AppStyle.mainHeadingBlack,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: AppStyle.defaultPadding),
                    height: 180,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: statusTypes.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppStyle.defaultPadding * 0.7,
                              horizontal: 5),
                          child: TaskCategory(
                            status: statusTypes[i],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.1),
                    child: Text(
                      "Upcoming Tasks - ${store.selectedTaskStatus}",
                      style: AppStyle.mainHeadingBlack,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Task>>(
                      future: store.getTasks(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          //return progress
                          return const Center(
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          );
                        } else {
                          //return widget
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15,
                            ),
                            itemCount: store.tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              Task task = store.tasks[index];
                              List<Employee> assignedEmployees =
                                  store.getAssignedEmployeesByTask(task.id);
                              return GestureDetector(
                                onTap: () {
                                  //move to new creen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TaskScreen(task: task),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.all(AppStyle.defaultPadding),
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.grey.withOpacity(0.8),
                                          blurRadius: 3,
                                          offset: const Offset(4, 4),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor:
                                              Status.getStatus(task.status)!
                                                  .color,
                                          foregroundColor: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              task.status,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 7),
                                              child: Text(
                                                task.taskName,
                                                style: AppStyle.subHeading_b,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 7),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    "Deadline: ",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    AppStyle.dateFormatter
                                                        .format(
                                                      store.calDeadline(
                                                          task.startDate,
                                                          task.duration),
                                                    ),
                                                    style: const TextStyle(
                                                        color: AppColor.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              height: 30,
                                              width: 100,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: assignedEmployees
                                                            .length <=
                                                        3
                                                    ? assignedEmployees.length
                                                    : 4,
                                                itemBuilder: (context, index) {
                                                  Employee assignee =
                                                      assignedEmployees[index];
                                                  if (index < 3) {
                                                    return Align(
                                                      widthFactor: 0.65,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            AppColor
                                                                .primaryColor,
                                                        radius: 15,
                                                        child: SizedBox(
                                                          child: Image.asset(
                                                            assignee.image,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Align(
                                                      widthFactor: 0.65,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            AppColor
                                                                .primaryColor,
                                                        foregroundColor:
                                                            AppColor.white,
                                                        radius: 15,
                                                        child: Text(
                                                          "+${assignedEmployees.length - 3}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ProgressCircle(
                                        taskProgress:
                                            store.calTaskProgress(task.id),
                                        radius: 30,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          //top part
          Container(
            padding: EdgeInsets.all(AppStyle.defaultPadding),
            height: screenScreen.height * 0.25,
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //intro
                    Text(
                      "Hi! ${store.user.name}",
                      style: AppStyle.mainHeading,
                    ),
                    //role
                    Text(
                      store.user.role,
                      style: const TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    // await store.insertSubtask(
                    //     store.tasks[0].id, store.tasks[0].subTasks[0]);
                  },
                  child: const Icon(
                    Icons.account_circle,
                    color: AppColor.white,
                    size: 50,
                  ),
                )
              ],
            ),
          ),
          //search box
          Positioned(
            top: screenScreen.width * 0.42,
            child: SizedBox(
              width: screenScreen.width * 0.85,
              child: TextField(
                //controller: TextEditingController(text:'data'),
                style: TextStyle(color: Colors.grey[800]),
                onChanged: (String text) {
                  store.setKey(text);
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColor.grey,
                  hintText: 'Search...',
                  suffixIcon: Icon(
                    Icons.search,
                    color: AppColor.black,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } //ef
} //ec

class TaskCategory extends StatelessWidget {
  TaskCategory({
    Key? key,
    required this.status,
  }) : super(key: key);
  final String status;

  @override
  Widget build(BuildContext context) {
    //firstly get status as an object
    Status? statusObj = Status.getStatus(status);
    var store = Provider.of<Store>(context);
    return GestureDetector(
      onTap: () {
        store.setSelectedTaskStatus(status);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 140,
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              blurRadius: 3,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
          color: (store.selectedTaskStatus == statusObj!.status ||
                  store.selectedTaskStatus == "All")
              ? statusObj.color
              : AppColor.darkGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppStyle.defaultPadding * 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.3),
                child: const Icon(
                  Icons.circle,
                  color: AppColor.white,
                  size: 35,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: AppStyle.defaultPadding * 0.15,
                ),
                child: Text(
                  statusObj.status,
                  style: AppStyle.mainTaskStatus,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: 5,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                    ),
                  ),
                  Text(
                    "${store.getTaskNumByStatus(statusObj.status)} projects",
                    style: const TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}//ec