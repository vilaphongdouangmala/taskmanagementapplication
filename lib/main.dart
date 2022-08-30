import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/styles/AppColor.dart';
import 'package:task_management_application/styles/AppStyle.dart';

import 'models/Status.dart';
import 'models/Task.dart';
import 'screens/HomeScreen.dart';

class Store extends ChangeNotifier {
  String connectionUrl = "http://192.168.183.189:1880/taskmanagement";

  //employees
  List<Employee> _employees = [];
  List<Employee> get employees => _employees;

  void setEmployees(List<Employee> employees) {
    _employees = employees;
  } //ef

  Future<List<Employee>> getEmployees() async {
    if (_employees.isEmpty) {
      var url = connectionUrl;
      var jsonText = await get(url);
      var dict = json.decode(jsonText) as List;
      List<Employee> employees = dict.map((e) => Employee.fromMap(e)).toList();
      setEmployees(employees);
      notifyListeners();
      return _employees;
    } //end if
    return _employees;
  } //ef

  //end employee region

  //tasks
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void setTasks(List<Task> tasks) {
    _tasks = tasks;
  } //ef

  Future<List<Task>> getTasks({refresh = false}) async {
    if (_tasks.isEmpty || refresh) {
      var url = connectionUrl;
      var jsonText = await get(connectionUrl);
      var dict = json.decode(jsonText) as List;
      List<Task> tasks = dict.map((e) => Task.fromMap(e)).toList();
      setTasks(tasks);
      notifyListeners();
      return _tasks;
    }
    return _tasks;
  } //ef

  //end task region

  //displayed tasks
  List<Task> _displayedTasks = [];
  List<Task> get displayedTasks => _displayedTasks;

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
      status: "Not Started",
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

