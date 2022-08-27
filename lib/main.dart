import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:task_management_application/models/Employee.dart';

import 'models/Task.dart';
import 'screens/HomeScreen.dart';

class Store extends ChangeNotifier {
  String connectionUrl = "http://192.168.183.148:1880/taskmanagement";

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

  Future<List<Task>> getTasks() async {
    if (_tasks.isEmpty) {
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

  Future<String> get(url) async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusCode);
      return Future<String>.value(null);
    }
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

