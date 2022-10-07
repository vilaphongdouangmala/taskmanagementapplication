import 'dart:convert';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:task_management_application/models/AssignedEmployee.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/models/SubTask.dart';
import 'package:task_management_application/screens/CreateTaskScreen.dart';
import 'package:task_management_application/screens/CalendarScreen.dart';
import 'package:task_management_application/screens/LoginScreen.dart';
import 'package:task_management_application/styles/AppColor.dart';
import 'package:task_management_application/styles/AppStyle.dart';
import 'package:collection/collection.dart';

import 'models/Status.dart';
import 'models/Task.dart';
import 'screens/HomeScreen.dart';

class Store extends ChangeNotifier {
  String connectionUrl = "http://192.168.182.224:1880";

  //tasks
  List<Task> _tasks = [];
  List<Task> get tasks {
    if (_key.isEmpty && _selectedTaskStatus == "All") {
      return _tasks;
    } else {
      return _tasks.where((task) {
        bool containNameCheck =
            task.taskName.toLowerCase().contains(_key.toLowerCase());
        if (_selectedTaskStatus != "All") {
          bool containStatusCheck = task.status == _selectedTaskStatus;
          return containNameCheck && containStatusCheck;
        } else {
          return containNameCheck;
        }
      }).toList();
    } //end if else
  } //ef

  DateTime _selectedDate = DateTime.utc(1956);
  DateTime get selectedDate => _selectedDate;
  String _key = "";
  String _selectedTaskStatus = "All";
  String get selectedTaskStatus => _selectedTaskStatus;

  void update() {
    notifyListeners();
  } //ef

  void setKey(String key) {
    _key = key;
    notifyListeners();
  } //ef

  void setSelectedTaskStatus(String status) {
    //if user press again we uncategorize
    if (_selectedTaskStatus == status) {
      _selectedTaskStatus = "All";
    } else {
      _selectedTaskStatus = status;
    }
    notifyListeners();
  } //ef

  void setSelectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  } //ef

  void setEmployees(List<Employee> employees) {
    _employees = employees;
  } //ef

  void setDisplayedEmployees(List<Employee> displayedEmployees) {
    _displayedEmployees = displayedEmployees;
  }

  //employees
  List<Employee> _employees = [];
  List<Employee> get employees => _employees;

  //available employees
  List<Employee> _availableEmployees = [];
  List<Employee> get availableEmployees {
    List<Employee> employees = [];
    return [];
  }

  //displayedEmployees
  List<Employee> _displayedEmployees = [];
  List<Employee> get displayedEmployees => _displayedEmployees;

  List<AssignedEmployee> _assignedEmployee = [];
  List<AssignedEmployee> get assignedEmployee => _assignedEmployee;

  void setAssignedEmployee(List<AssignedEmployee> assignedEmployees) {
    _assignedEmployee = assignedEmployees;
  }

  Future<List<AssignedEmployee>> getAssignedEmployees() async {
    if (_assignedEmployee.isEmpty) {
      var url = "$connectionUrl/assignedemployeehandle";
      var jsonText = await get(url);
      var dict = json.decode(jsonText) as List;
      List<AssignedEmployee> assignedEmployees =
          dict.map((e) => AssignedEmployee.fromMap(e)).toList();
      setAssignedEmployee(assignedEmployees);
      notifyListeners();
      return _assignedEmployee;
    } //end if
    return _assignedEmployee;
  }

  List<Employee> getAssignedEmployeesByTask(int taskId) {
    List<Employee> employees = [];
    for (AssignedEmployee ae in _assignedEmployee) {
      if (ae.taskId == taskId) {
        Employee? employee =
            _employees.firstWhereOrNull((e) => e.id == ae.employeeId);
        if (employee != null) {
          employees.add(employee);
        }
      }
    }
    return employees;
  } //ef

  List<Employee> getAvailableEmployeesByTask(int taskId) {
    List<Employee> employees = [];
    List<AssignedEmployee> aeById = [];
    for (AssignedEmployee ae in _assignedEmployee) {
      if (ae.taskId == taskId) {
        aeById.add(ae);
      }
    }
    for (Employee employee in _employees) {
      var found = aeById.firstWhereOrNull((e) => e.employeeId == employee.id);
      if (found == null) {
        employees.add(employee);
      }
    }
    return employees;
  } //ef

  Future<List<Employee>> getEmployees() async {
    if (_employees.isEmpty) {
      var url = "$connectionUrl/employeehandle";
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
    // print(_availableEmployees);
  } //ef
  //end employee region

  void setTasks(List<Task> tasks) {
    _tasks = tasks;
  } //ef

  Future<List<Task>> getTasks({refresh = false}) async {
    var url = "$connectionUrl/taskhandle";

    if (_tasks.isEmpty || refresh) {
      var data = {
        "operation": "query",
      };
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: json.encode(data),
      );
      var result = response.body;
      var dict = json.decode(result) as List;

      // var jsonText = await get(url);
      // var dict = json.decode(jsonText)["tasks"] as List;
      List<Task> tasks = dict.map((e) => Task.fromMap(e)).toList();
      List<SubTask> subtasks = await getSubtasksDb();
      //get employees in this process also
      List<Employee> employees = await getEmployees();
      List<AssignedEmployee> assignedEmployees = await getAssignedEmployees();

      //set
      setTasks(tasks);
      setSubtasks(subtasks);
      setEmployees(employees);
      setAssignedEmployee(assignedEmployees);
      notifyListeners();
      return _tasks;
    }
    return _tasks;
  } //ef

  int _taskId = -1;
  void setTaskId(int id) {
    _taskId = id;
  } //ef

  bool _firstLoadSubtasks = true;

  List<SubTask> _subtasks = [];
  List<SubTask> get subtasks {
    if (_selectedDate != DateTime.utc(1956)) {
      return getSubTaskByDate(_selectedDate);
    } else if (_taskId == -1) {
      return _subtasks;
    } else {
      return getSubtasksById(_taskId);
    }
  } //ef

  void setSubtasks(List<SubTask> subtasks) {
    _subtasks = subtasks;
    notifyListeners();
  } //ef

  Future<List<SubTask>> getSubtasksDb() async {
    if (_subtasks.isEmpty) {
      var url = "$connectionUrl/subtaskhandle";
      var data = {
        // "taskId": _taskId,
        "operation": "query",
      };
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: json.encode(data),
      );
      var result = response.body;
      var dict = json.decode(result) as List;
      List<SubTask> subtaskList = dict.map((e) => SubTask.fromMap(e)).toList();
      for (Task task in _tasks) {
        for (SubTask subtask in subtaskList) {
          if (task.id == subtask.taskId) {
            subtasks.add(subtask);
          }
        }
      } //
      setSubtasks(subtaskList);
      notifyListeners();
      return _subtasks;
    } //end if
    return _subtasks;
  } //ef

  List<SubTask> getSubtasksById(int id) {
    List<SubTask> subtasks = [];
    for (SubTask subtask in _subtasks) {
      if (subtask.taskId == id) {
        subtasks.add(subtask);
      }
    }
    return subtasks;
  }

  List<SubTask> getAllSubtasks() {
    List<SubTask> subtasks = [];
    for (Task task in _tasks) {
      for (SubTask subtask in subtasks) {
        subtasks.add(subtask);
      } //eloop subtasks
    } //eloop tasks
    return subtasks;
  } //ef

  //get subtasks on calendar screen
  List<SubTask> getSubTaskByDate(DateTime date) {
    List<SubTask> subtasks = [];
    for (SubTask subtask in _subtasks) {
      bool sameDate =
          AppStyle.dateFormatter.format(DateTime.parse(subtask.datetime)) ==
              AppStyle.dateFormatter.format(date);
      if (sameDate) {
        subtasks.add(subtask);
      }
    }
    return subtasks;
  } //ef

  Future<void> insertSubtask(SubTask subtask, String insertType) async {
    if (insertType != "temp") {
      var url = "$connectionUrl/subtaskhandle";
      var dict = {
        "subtask": subtask.toMap(),
        "operation": "insert",
      };
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: json.encode(dict),
      );
    }
    //add to existing subtask
    _subtasks.add(subtask);
    notifyListeners();
  } //ef

  void removeSubtask(SubTask subtask) {
    _subtasks.removeWhere((element) => element.id == subtask.id);
    notifyListeners();
  }

  //end subtask region

  double calTaskProgress(int taskId) {
    int completeCount = 0;
    int totalSubtask = 0;
    for (SubTask subtask in _subtasks) {
      if (subtask.taskId == taskId) {
        totalSubtask += 1;
        if (subtask.complete == true) {
          completeCount += 1;
        } //end if
      }
    } //eloop
    return (completeCount / totalSubtask);
  } //ef

  //end task region

  Future<String> get(url) async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusCode);
      return Future<String>.value(null);
    }
  } //ef

  void setNewTask(Task task) {
    tasks.add(task);
    notifyListeners();
  } //ef

  int getTaskNumByStatus(String status) {
    int counter = 0;
    for (Task task in _tasks) {
      if (task.status == status) {
        counter += 1;
      }
    } //eloop
    return counter;
  } //ef

  DateTime calDeadline(String startDate, int day) {
    DateTime convertedStartDate = DateTime.parse(startDate);
    return convertedStartDate.add(Duration(days: day));
  } //ef

  //bottom nav
  final List<Widget> _tabs = <Widget>[HomeScreen(), CaldendarScreen()];
  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;

  void setTabChange(int tabIndex) {
    //reset date
    _selectedDate = DateTime.utc(1956);
    _bottomNavIndex = tabIndex;
    notifyListeners();
  } //ef

  final iconList = <IconData>[
    Icons.home,
    Icons.calendar_today,
  ];

  //login user
  Employee? _user = null;
  Employee get user => _user!;

  void setUser(Employee user) {
    _user = user;
    notifyListeners();
  } //ef
} //ec

main() {
  return runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => Store(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Urbanist',
          textTheme: const TextTheme(
            bodyText1: TextStyle(fontSize: 16),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    ),
  );
} //ef

//===> class: AppMain
class AppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Store>(context);
    bool showFloatingBtn = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: store._tabs[store._bottomNavIndex],
      floatingActionButton: store.user.role.toLowerCase() == "manager"
          ? Visibility(
              visible: !showFloatingBtn,
              child: CircleAvatar(
                backgroundColor: AppColor.white,
                radius: 38,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () {
                      //move to new creen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateTaskScreen(),
                        ),
                      );
                    },
                    backgroundColor: AppColor.primaryColor,
                    child: const Icon(
                      Icons.add,
                      size: 35,
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: AppColor.primaryColor,
        activeIndex: store.bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        notchMargin: -5,
        leftCornerRadius: 30,
        rightCornerRadius: 30,
        onTap: (index) => store.setTabChange(index),
        itemCount: store.iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? AppColor.primaryYellow : AppColor.white;
          return Icon(
            store.iconList[index],
            size: 30,
            color: color,
          );
        },
      ),
    );
  } //ef
} //ec
