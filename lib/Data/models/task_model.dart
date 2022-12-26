import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModal {
  TaskModal({
    this.name,
    this.id,
    this.description,
    this.priority,
    this.status,
    this.projectId,
    this.userId,
    this.timeSuccess,
    this.createAt,
    this.updateAt,
  });

  String? name;
  final String? id;
  final String? projectId;
  final String? userId;
  final String? description;
  final String? priority;
  final String? status;
  final String? timeSuccess;
  final DateTime? createAt;
  final DateTime? updateAt;
  String show() {
    return "${name} + ${description}";
  }

  static TaskModal fromJson(Map<String, dynamic> json) => TaskModal(
        name: json['name'],
        description: json['description'],
      );
  // createAt: (json['birthday'] as Timestamp).toDate()
}
