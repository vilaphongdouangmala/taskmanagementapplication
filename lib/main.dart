import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/styles/AppColor.dart';
import 'package:task_management_application/styles/AppStyle.dart';
import 'package:collection/collection.dart';

import 'models/Status.dart';
import 'models/Task.dart';
import 'screens/HomeScreen.dart';

class Store extends ChangeNotifier {
  String connectionUrl = "http://192.168.183.41:1880";

  //employees
  List<Employee> _employees = [];
  List<Employee> get employees => _employees;

  //available employees
  List<Employee> _availableEmployees = [];
  List<Employee> get availableEmployees => _availableEmployees;

  //displayedEmployees
  List<Employee> _displayedEmployees = [];
  List<Employee> get displayedEmployees => _displayedEmployees;

  //tasks
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  //displayed tasks
  List<Task> _displayedTasks = [];
  List<Task> get displayedTasks => _displayedTasks;

  void setEmployees(List<Employee> employees) {
    _employees = employees;
  } //ef

  void setDisplayedEmployees(List<Employee> displayedEmployees) {
    _displayedEmployees = displayedEmployees;
  }

  Future<List<Employee>> getEmployees() async {
    if (_employees.isEmpty) {
      var url = "$connectionUrl/getEmployees";
      var jsonText = await get(url);
      var dict = json.decode(jsonText) as List;
      List<Employee> employees = dict.map((e) => Employee.fromMap(e)).toList();
      setEmployees(employees);
      notifyListeners();
      return _employees;
    } //end if
    return _employees;
  } //ef

  void setAvailableEmployees(List<Employee> employees) {
    _availableEmployees = employees;
  }

  void getAvailableEmployees(List<Employee> assignedPeople) {
    _availableEmployees.clear();
    for (Employee employee in _employees) {
      //if employee is not in the assignedPeople list, we show those employees (they are available)
      if (assignedPeople.firstWhereOrNull((e) => e.id == employee.id) == null) {
        _availableEmployees.add(employee);
      } //end if
    } //end loop
  } //ef
  //end employee region

  void setTasks(List<Task> tasks) {
    _tasks = tasks;
  } //ef

  Future<List<Task>> getTasks({refresh = false}) async {
    if (_tasks.isEmpty || refresh) {
      var url = "$connectionUrl/getTasks";
      var jsonText = await get(url);
      var dict = json.decode(jsonText) as List;
      List<Task> tasks = dict.map((e) => Task.fromMap(e)).toList();
      setTasks(tasks);
      notifyListeners();
      return _tasks;
    }
    return _tasks;
  } //ef

  //end task region

  void setDisplayedTasks(List<Task> displayedTasks) {
    _displayedTasks = displayedTasks;
  } //ef

  void getDisplayedTasksByDate({DateTime? filteredDate}) {
    if (filteredDate != null) {
      _displayedTasks.clear();
      String strFilteredDate = AppStyle.dateFormatter.format(filteredDate);
      for (Task t in _tasks) {
        if (t.deadline == strFilteredDate) {
          _displayedTasks.add(t);
        } //eif
      } //eloop
      notifyListeners();
    } else {
      _displayedTasks = _tasks;
    }
  } //ef

  Future<String> get(url) async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusCode);
      return Future<String>.value(null);
    }
  } //ef

  //might need to change string to Datetime
  void createNewTask(String taskName, String startDate, String deadline) {
    int id = tasks.length + 1;
    Task newTask = Task(
      id: id,
      taskName: taskName,
      taskDescription: "lorem ipsum",
      status: "Complete",
      startDate: startDate,
      deadline: deadline,
      assignedPeople: [
        Employee(
          id: 1,
          name: "name",
          role: "role",
          image: "image",
        ),
      ],
    );
    tasks.add(newTask);
    notifyListeners();
  } //ef

  //employees
  // ignore: prefer_final_fields
  List<Employee> _employeeList = [
    Employee(
      id: 4,
      name: "andy",
      role: "Full-stack Developer",
      image: "assets/icons/e1.png",
    ),
    Employee(
      id: 5,
      name: "jamppi",
      role: "System Analyst",
      image: "assets/icons/e1.png",
    ),
    Employee(
      id: 6,
      name: "nammi",
      role: "Frontend Developer",
      image: "assets/icons/e1.png",
    ),
  ];
  List<Employee> get employeeList => _employeeList;
} //ec

main() {
  return runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => Store(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
} //ef
