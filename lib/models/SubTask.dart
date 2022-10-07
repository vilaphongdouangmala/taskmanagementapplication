import 'dart:convert';

class SubTask {
  final int id;
  final String name;
  bool complete;
  String datetime;
  int taskId;
  SubTask({
    required this.id,
    required this.name,
    required this.complete,
    required this.datetime,
    required this.taskId,
  });

  SubTask copyWith({
    int? id,
    String? name,
    bool? complete,
    String? datetime,
    int? taskId,
  }) {
    return SubTask(
      id: id ?? this.id,
      name: name ?? this.name,
      complete: complete ?? this.complete,
      datetime: datetime ?? this.datetime,
      taskId: taskId ?? this.taskId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'complete': complete,
      'datetime': datetime,
      'taskId': taskId,
    };
  }

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      complete: map['complete'] == 0 ? false : true,
      datetime: map['datetime'] as String,
      taskId: map['taskId'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTask.fromJson(String source) =>
      SubTask.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubTask(id: $id, name: $name, complete: $complete, datetime: $datetime, taskId: $taskId)';
  }

  @override
  bool operator ==(covariant SubTask other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.complete == complete &&
        other.datetime == datetime &&
        other.taskId == taskId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        complete.hashCode ^
        datetime.hashCode ^
        taskId.hashCode;
  }
}
