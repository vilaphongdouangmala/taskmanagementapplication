import 'dart:convert';

class SubTask {
  final int id;
  final String name;
  bool complete;
  SubTask({
    required this.id,
    required this.name,
    required this.complete,
  });

  SubTask copyWith({
    int? id,
    String? name,
    bool? complete,
  }) {
    return SubTask(
      id: id ?? this.id,
      name: name ?? this.name,
      complete: complete ?? this.complete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'complete': complete,
    };
  }

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      complete: map['complete'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTask.fromJson(String source) =>
      SubTask.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SubTask(id: $id, name: $name, complete: $complete)';

  @override
  bool operator ==(covariant SubTask other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.complete == complete;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ complete.hashCode;
}
