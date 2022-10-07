//===> class: AddAssigneeCard
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_application/components/LongButton.dart';
import 'package:task_management_application/models/AssignedEmployee.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/styles/AppColor.dart';
import 'package:task_management_application/styles/AppStyle.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  List<Employee> availableEmployees = [];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    store = Provider.of<Store>(context);
    // //get available employees
    List<Employee> assignedEmployees =
        store.getAssignedEmployeesByTask(widget.task.id);
    // store.getAvailableEmployees(assignedEmployees);
    if (searchBox.text.isEmpty) {
      availableEmployees = store.getAvailableEmployeesByTask(widget.task.id);
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.065,
          horizontal: screenSize.width * 0.06),
      child: Hero(
        tag: 'assign',
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: AppStyle.defaultPadding * 0.7),
                      child: const Text(
                        "Assign Employees",
                        style: AppStyle.subHeading_b,
                      ),
                    ),
                  ),
                  const ListTileTitle(
                    text: "Current Assignees: ",
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: AppStyle.defaultPadding * 1.5),
                    child: SizedBox(
                      height: screenSize.height * 0.25,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(0),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: assignedEmployees.length,
                        itemBuilder: (context, i) {
                          Employee assignee = assignedEmployees[i];
                          return Slidable(
                            key: UniqueKey(),
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: AppColor.primaryColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Remove',
                                  onPressed: (context) {
                                    removeAssignees(assignee);
                                  },
                                ),
                              ],
                            ),
                            child: EmployeeListTile(
                              employee: assignee,
                              icon: null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.2),
                    child: const ListTileTitle(
                      text: "Available Employees: ",
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.5),
                    height: 40,
                    child: TextField(
                      controller: searchBox,
                      style: TextStyle(color: Colors.grey[800]),
                      onChanged: (String text) {
                        getavailableEmployees(text);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        hintText: 'Search...',
                      ),
                    ),
                  ),

                  //available employees
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: screenSize.height * 0.25,
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
                          return ListView.separated(
                            padding: const EdgeInsets.all(0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: availableEmployees.length,
                            itemBuilder: (BuildContext context, int i) {
                              Employee employee = availableEmployees[i];
                              return EmployeeListTile(
                                employee: employee,
                                icon: GestureDetector(
                                  onTap: () {
                                    addAssignees(availableEmployees[i]);
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: AppColor.primaryColor,
                                    foregroundColor: AppColor.white,
                                    radius: 17,
                                    child: Icon(
                                      Icons.add,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  LongButton(
                      press: () {
                        Navigator.pop(context);
                      },
                      text: 'Done')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  } //ef

  void removeAssignees(Employee employee) {
    store.availableEmployees.add(
      employee,
    );
    store.assignedEmployee.removeWhere((e) => e.employeeId == employee.id);
    store.update();
  } //ef

  void addAssignees(Employee employee) {
    store.assignedEmployee.add(AssignedEmployee(
      id: store.assignedEmployee.length + 1,
      taskId: widget.task.id,
      employeeId: employee.id,
    ));
    store.availableEmployees.remove(
      employee,
    );
    store.update();
  }

  void getavailableEmployees(String searchedName) {
    List<Employee> searchedEmployees = availableEmployees.where((e) {
      final employeeName = e.name.toLowerCase();
      final query = searchedName.toLowerCase();
      return employeeName.contains(query);
    }).toList();
    setState(() {
      availableEmployees = searchedEmployees;
    });
  } //ef
}

class ListTileTitle extends StatelessWidget {
  const ListTileTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.5),
      child: Text(
        text,
      ),
    );
  }
}

class EmployeeListTile extends StatelessWidget {
  const EmployeeListTile({
    Key? key,
    required this.employee,
    required this.icon,
  }) : super(key: key);

  final Employee employee;
  final GestureDetector? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        leading: SizedBox(
          width: 40,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(
              employee.image,
            ),
          ),
        ),
        title: Text(employee.name),
        subtitle: Text(employee.role),
        trailing: icon,
      ),
    );
  }
}//ec
