//===> class: AddAssigneeCard
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/styles/AppColor.dart';
import 'package:task_management_application/styles/AppStyle.dart';

import '../main.dart';
import '../models/Task.dart';

class AddAssigneeCard extends StatefulWidget {
  final Task task;
  AddAssigneeCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<AddAssigneeCard> createState() => _AddAssigneeCardState();
}

class _AddAssigneeCardState extends State<AddAssigneeCard> {
  TextEditingController searchBox = TextEditingController();

  late Store store;

  List<Employee> displayedEmployees = [];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    store = Provider.of<Store>(context);
    //get available employees
    store.getAvailableEmployees(widget.task.assignedPeople);
    if (searchBox.text.isEmpty) {
      displayedEmployees = store.availableEmployees;
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.10,
          horizontal: screenSize.width * 0.08),
      child: Hero(
        tag: 'assign',
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.7,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: AppStyle.defaultPadding * 0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Assign Employees",
                            style: AppStyle.subHeading_b,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Done",
                              style: AppStyle.pagePopText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.5),
                    child: Text(
                      widget.task.taskName,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.5),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColor.grey,
                      ),
                      height: 150,
                      width: screenSize.width * 0.7,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: widget.task.assignedPeople.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.task.assignedPeople[i].name,
                                ),
                                Text(
                                  widget.task.assignedPeople[i].role,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    store.availableEmployees.add(
                                      widget.task.assignedPeople[i],
                                    );
                                    widget.task.assignedPeople.remove(
                                      widget.task.assignedPeople[i],
                                    );
                                    store.notifyListeners();
                                  },
                                  child: const CircleAvatar(
                                    radius: 15,
                                    child: Icon(
                                      Icons.remove,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.7,
                    height: 40,
                    child: TextField(
                      controller: searchBox,
                      style: TextStyle(color: Colors.grey[800]),
                      onChanged: (String text) {
                        getDisplayedEmployees(text);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Search...',
                      ),
                    ),
                  ),
                  //available employees
                  SizedBox(
                    height: 200,
                    width: screenSize.width * 0.7,
                    child: FutureBuilder<List<Object>>(
                      future: store.getEmployees(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          //return progress
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          //return widget
                          return ListView.builder(
                            itemCount: displayedEmployees.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    displayedEmployees[i].name,
                                  ),
                                  Text(
                                    displayedEmployees[i].role,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.task.assignedPeople.add(
                                        store.availableEmployees[i],
                                      );
                                      store.availableEmployees.remove(
                                        store.availableEmployees[i],
                                      );
                                      store.notifyListeners();
                                    },
                                    child: const CircleAvatar(
                                      radius: 15,
                                      child: Icon(
                                        Icons.add,
                                      ),
                                    ),
                                  ),
                                ],
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
        ),
      ),
    );
  }

  //ef
  void getDisplayedEmployees(String searchedName) {
    // _displayedEmployees.clear();
    // if (employeeName.isEmpty) {
    //   _displayedEmployees = _availableEmployees;
    // } else {
    //   for (Employee e in _availableEmployees) {
    //     if (e.name.toLowerCase().contains(employeeName.toLowerCase())) {
    //       _displayedEmployees.add(e);
    //     } //end if
    //   } //eloop
    // } //end if else

    List<Employee> searchedEmployees = store.availableEmployees.where((e) {
      final employeeName = e.name.toLowerCase();
      final query = searchedName.toLowerCase();
      return employeeName.contains(query);
    }).toList();
    setState(() {
      displayedEmployees = searchedEmployees;
    });
  } //ef
}//ec
