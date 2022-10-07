import 'dart:convert';

class AssignedEmployee {
  final int id;
  final int taskId;
  final int employeeId;
  AssignedEmployee({
    required this.id,
    required this.taskId,
    required this.employeeId,
  });

  AssignedEmployee copyWith({
    int? id,
    int? taskId,
    int? employeeId,
  }) {
    return AssignedEmployee(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'taskId': taskId,
      'employeeId': employeeId,
    };
  }

  factory AssignedEmployee.fromMap(Map<String, dynamic> map) {
    return AssignedEmployee(
      id: map['id'].toInt() as int,
      taskId: map['taskId'].toInt() as int,
      employeeId: map['employeeId'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignedEmployee.fromJson(String source) =>
      AssignedEmployee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AssignedEmployee(id: $id, taskId: $taskId, employeeId: $employeeId)';

  @override
  bool operator ==(covariant AssignedEmployee other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.taskId == taskId &&
        other.employeeId == employeeId;
  }

  @override
  int get hashCode => id.hashCode ^ taskId.hashCode ^ employeeId.hashCode;
}
