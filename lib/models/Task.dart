import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/models/SubTask.dart';

class Task {
  String taskName;
  String taskDescription;
  String status;
  String startDate;
  int duration;
  List<Employee> assignedPeople;
  List<SubTask> subTasks;
  Task({
    required this.taskName,
    required this.taskDescription,
    required this.status,
    required this.startDate,
    required this.duration,
    required this.assignedPeople,
    required this.subTasks,
  });

  Task copyWith({
    String? taskName,
    String? taskDescription,
    String? status,
    String? startDate,
    int? duration,
    List<Employee>? assignedPeople,
    List<SubTask>? subTasks,
  }) {
    return Task(
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      duration: duration ?? this.duration,
      assignedPeople: assignedPeople ?? this.assignedPeople,
      subTasks: subTasks ?? this.subTasks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskName': taskName,
      'taskDescription': taskDescription,
      'status': status,
      'startDate': startDate,
      'duration': duration,
      'assignedPeople': assignedPeople.map((x) => x.toMap()).toList(),
      'subTasks': subTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskName: map['taskName'] as String,
      taskDescription: map['taskDescription'] as String,
      status: map['status'] as String,
      startDate: map['startDate'] as String,
      duration: map['duration'].toInt() as int,
      assignedPeople: List<Employee>.from(
        (map['assignedPeople'] as List<dynamic>).map<Employee>(
          (x) => Employee.fromMap(x as Map<String, dynamic>),
        ),
      ),
      subTasks: List<SubTask>.from(
        (map['subTasks'] as List<dynamic>).map<SubTask>(
          (x) => SubTask.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(taskName: $taskName, taskDescription: $taskDescription, status: $status, startDate: $startDate, duration: $duration, assignedPeople: $assignedPeople, subTasks: $subTasks)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.taskName == taskName &&
        other.taskDescription == taskDescription &&
        other.status == status &&
        other.startDate == startDate &&
        other.duration == duration &&
        listEquals(other.assignedPeople, assignedPeople) &&
        listEquals(other.subTasks, subTasks);
  }

  @override
  int get hashCode {
    return taskName.hashCode ^
        taskDescription.hashCode ^
        status.hashCode ^
        startDate.hashCode ^
        duration.hashCode ^
        assignedPeople.hashCode ^
        subTasks.hashCode;
  }
}//ec
