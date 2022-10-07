import 'dart:convert';

class Task {
  int id;
  String taskName;
  String taskDescription;
  String status;
  String startDate;
  int duration;
  Task({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.status,
    required this.startDate,
    required this.duration,
  });

  Task copyWith({
    int? id,
    String? taskName,
    String? taskDescription,
    String? status,
    String? startDate,
    int? duration,
  }) {
    return Task(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'status': status,
      'startDate': startDate,
      'duration': duration,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'].toInt() as int,
      taskName: map['taskName'] as String,
      taskDescription: map['taskDescription'] as String,
      status: map['status'] as String,
      startDate: map['startDate'] as String,
      duration: map['duration'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, taskName: $taskName, taskDescription: $taskDescription, status: $status, startDate: $startDate, duration: $duration)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.taskName == taskName &&
        other.taskDescription == taskDescription &&
        other.status == status &&
        other.startDate == startDate &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        taskName.hashCode ^
        taskDescription.hashCode ^
        status.hashCode ^
        startDate.hashCode ^
        duration.hashCode;
  }
}
