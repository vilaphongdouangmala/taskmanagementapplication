//===> class: #name#
import 'package:flutter/material.dart';
import 'package:task_management_application/styles/AppColor.dart';
import 'package:task_management_application/styles/AppStyle.dart';

import '../models/Task.dart';

class CreateTaskScreen extends StatelessWidget {
  //controllers
  TextEditingController taskName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.white,
                      ),
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
                    TextField(
                      controller: taskName,
                      style: TextStyle(color: Colors.grey[800]),
                      onChanged: (String text) {},
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Task Name',
                      ),
                    ),
                    //Deadline
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppStyle.defaultPadding * 1.5),
                      child: Column(
                        children: [
                          const Text(
                            "Deadline",
                            style: AppStyle.subHeading,
                          ),
                          Container(
                            width: screenSize.width * 0.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.black,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.edit_calendar,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  } //ef
}//ec