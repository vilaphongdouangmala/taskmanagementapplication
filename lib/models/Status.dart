import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_management_application/styles/AppColor.dart';
import 'package:collection/collection.dart';

class Status {
  final String status;
  final dynamic color;
  Status({
    required this.status,
    required this.color,
  });

  Status copyWith({
    String? status,
    dynamic color,
  }) {
    return Status(
      status: status ?? this.status,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'color': color,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      status: map['status'] as String,
      color: map['color'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) =>
      Status.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Status(status: $status, color: $color)';

  @override
  bool operator ==(covariant Status other) {
    if (identical(this, other)) return true;

    return other.status == status && other.color == color;
  }

  @override
  int get hashCode => status.hashCode ^ color.hashCode;

  static List<Status> statuses = [
    Status(
      status: "Not Started",
      color: Colors.grey[300],
    ),
    Status(
      status: "In Progress",
      color: AppColor.primaryYellow,
    ),
    Status(
      status: "Urgent",
      color: AppColor.primaryRed,
    ),
    Status(
      status: "Complete",
      color: AppColor.primaryGreen,
    ),
  ];

  static Status? getStatus(String status) {
    Status? found = statuses.firstWhereOrNull((e) => e.status == status);
    if (found != null) {
      return found;
    }
    return null;
  } //ef
}
