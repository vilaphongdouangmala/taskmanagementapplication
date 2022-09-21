import 'dart:convert';

class SubTask {
  final int id;
  final String name;
  bool complete;
  String datetime;
  SubTask({
    required this.id,
    required this.name,
    required this.complete,
    required this.datetime,
  });

  SubTask copyWith({
    int? id,
    String? name,
    bool? complete,
    String? datetime,
  }) {
    return SubTask(
      id: id ?? this.id,
      name: name ?? this.name,
      complete: complete ?? this.complete,
      datetime: datetime ?? this.datetime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'complete': complete,
      'datetime': datetime,
    };
  }

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      complete: map['complete'] as bool,
      datetime: map['datetime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTask.fromJson(String source) =>
      SubTask.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubTask(id: $id, name: $name, complete: $complete, datetime: $datetime)';
  }

  @override
  bool operator ==(covariant SubTask other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.complete == complete &&
        other.datetime == datetime;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ complete.hashCode ^ datetime.hashCode;
  }
}
