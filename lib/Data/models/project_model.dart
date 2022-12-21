import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/Data/models/user_model.dart';

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
  final List<UserModal>? users;
  final List<TaskModal>? tasks;
  final DateTime? createAt;
  final DateTime? updateAt;
}