import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModal {
  ProjectModal({
    this.name,
    this.id,
    this.shortName,
    this.description,
    this.users,
    this.tasks,
    this.createAt,
    this.updateAt,
  });

  final String? name;
  final String? id;
  final String? shortName;
  final String? description;
  final List? users;
  final List? tasks;
  final DateTime? createAt;
  final DateTime? updateAt;

  static ProjectModal fromJson(Map<String, dynamic> json) => ProjectModal(
        id: json["id"],
        name: json['name'],
        shortName: json['shortName'],
        description: json['description'],
        users: (json['users'] ?? [] as List).toList(),
        tasks: (json['task'] ?? [] as List).toList(),
        createAt: (json['createAt'] as Timestamp).toDate(),
        updateAt: (json['updateAt'] as Timestamp).toDate(),
      );

        Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "shortName": shortName,
        "tasks": tasks,
        "users": users,
        "createAt": createAt,
        "updateAt": updateAt,
      };
}
