import 'dart:convert';

class Employee {
  final int id;
  final String name;
  final String role;
  Employee({
    required this.id,
    required this.name,
    required this.role,
  });

  Employee copyWith({
    int? id,
    String? name,
    String? role,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Employee(id: $id, name: $name, role: $role)';

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.role == role;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ role.hashCode;
}
