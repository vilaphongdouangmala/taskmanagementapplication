import 'dart:convert';

class Employee {
  final int id;
  final String name;
  final String role;
  final String image;
  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
  });

  Employee copyWith({
    int? id,
    String? name,
    String? role,
    String? image,
  }) {
    return Employee(
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

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      role: map['role'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, role: $role, image: $image)';
  }

  @override
  bool operator ==(covariant Employee other) {
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
