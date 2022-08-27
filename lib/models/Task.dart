import 'dart:convert';

class Task {
  final int id;
  final String taskName;
  final String status;
  final String deadline;
  final String assignedPeople;
  Task({
    required this.id,
    required this.taskName,
    required this.status,
    required this.deadline,
    required this.assignedPeople,
  });

  Task copyWith({
    int? id,
    String? taskName,
    String? status,
    String? deadline,
    String? assignedPeople,
  }) {
    return Task(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      status: status ?? this.status,
      deadline: deadline ?? this.deadline,
      assignedPeople: assignedPeople ?? this.assignedPeople,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'taskName': taskName,
      'status': status,
      'deadline': deadline,
      'assignedPeople': assignedPeople,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'].toInt() as int,
      taskName: map['taskName'] as String,
      status: map['status'] as String,
      deadline: map['deadline'] as String,
      assignedPeople: map['assignedPeople'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, taskName: $taskName, status: $status, deadline: $deadline, assignedPeople: $assignedPeople)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.taskName == taskName &&
        other.status == status &&
        other.deadline == deadline &&
        other.assignedPeople == assignedPeople;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        taskName.hashCode ^
        status.hashCode ^
        deadline.hashCode ^
        assignedPeople.hashCode;
  }
}
