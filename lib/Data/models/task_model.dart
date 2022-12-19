class TaskModal {
  TaskModal({
    this.name,
    this.id,
    this.description,
    this.priority,
    this.status,
    this.projectId,
    this.userId,
    this.createAt,
    this.updateAt,
  });

  final String? name;
  final String? id;
  final String? projectId;
  final String? userId;
  final String? description;
  final String? priority;
  final String? status;
  final DateTime? createAt;
  final DateTime? updateAt;
}