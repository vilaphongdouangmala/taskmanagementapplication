import 'package:flutter/material.dart';
import 'package:task_management_application/styles/AppColor.dart';

import '../models/Employee.dart';
import '../models/Task.dart';
import '../screens/AddAssigneeCard.dart';
import 'HeroDialogRoute.dart';

class AssigneeListView extends StatelessWidget {
  const AssigneeListView({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          width: screenSize.width * 0.7,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: task.assignedPeople.length + 1,
            itemBuilder: (context, i) {
              if (i < task.assignedPeople.length) {
                Employee assignedPeople = task.assignedPeople[i];
                return Align(
                  widthFactor: 0.65,
                  child: CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColor.primaryColor,
                    backgroundImage: AssetImage(
                      assignedPeople.image,
                    ),
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      HeroDialogRoute(
                        builder: (context) {
                          return AddAssigneeCard(
                            task: task,
                          );
                        },
                      ),
                    );
                  },
                  child: const Hero(
                    tag: 'assign',
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: AppColor.primaryColor,
                      child: Icon(
                        Icons.add,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20),
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).push(
        //         HeroDialogRoute(
        //           builder: (context) {
        //             return AddAssigneeCard(
        //               task: task,
        //             );
        //           },
        //         ),
        //       );
        //     },
        //     child: const Hero(
        //       tag: 'assign',
        //       child: CircleAvatar(
        //         backgroundColor: AppColor.primaryColor,
        //         child: Icon(
        //           Icons.add,
        //           color: AppColor.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  } //ef
}//ec