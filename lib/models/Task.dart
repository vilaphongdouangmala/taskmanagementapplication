import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/models/Status.dart';

class Task {
  final int id;
  final String taskName;
  final String taskDescription;
  String status;
  final String startDate;
  final String deadline;
  final List<Employee> assignedPeople;
  Task({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.status,
    required this.startDate,
    required this.deadline,
    required this.assignedPeople,
  });

  Task copyWith({
    int? id,
    String? taskName,
    String? taskDescription,
    String? status,
    String? startDate,
    String? deadline,
    List<Employee>? assignedPeople,
  }) {
    return Task(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      deadline: deadline ?? this.deadline,
      assignedPeople: assignedPeople ?? this.assignedPeople,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'status': status,
      'startDate': startDate,
      'deadline': deadline,
      'assignedPeople': assignedPeople.map((x) => x.toMap()).toList(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'].toInt() as int,
      taskName: map['taskName'] as String,
      taskDescription: map['taskDescription'] as String,
      status: map['status'] as String,
      startDate: map['startDate'] as String,
      deadline: map['deadline'] as String,
      assignedPeople: List<Employee>.from(
        (map['assignedPeople'] as List<dynamic>).map<Employee>(
          (x) => Employee.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, taskName: $taskName, taskDescription: $taskDescription, status: $status, startDate: $startDate, deadline: $deadline, assignedPeople: $assignedPeople)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.taskName == taskName &&
        other.taskDescription == taskDescription &&
        other.status == status &&
        other.startDate == startDate &&
        other.deadline == deadline &&
        listEquals(other.assignedPeople, assignedPeople);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        taskName.hashCode ^
        taskDescription.hashCode ^
        status.hashCode ^
        startDate.hashCode ^
        deadline.hashCode ^
        assignedPeople.hashCode;
  }
}

class AssignedPeople {
  final int id;
  final String name;
  final String role;
  final String image;
  AssignedPeople({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
  });

  AssignedPeople copyWith({
    int? id,
    String? name,
    String? role,
    String? image,
  }) {
    return AssignedPeople(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'image': image,
    };
  }

  factory AssignedPeople.fromMap(Map<String, dynamic> map) {
    return AssignedPeople(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      role: map['role'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignedPeople.fromJson(String source) =>
      AssignedPeople.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssignedPeople(id: $id, name: $name, role: $role, image: $image)';
  }

  @override
  bool operator ==(covariant AssignedPeople other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.role == role &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ role.hashCode ^ image.hashCode;
  }
}
