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
  final List? users;
  final List? tasks;
  final String? id;
  final String? shortName;
  final String? description;
  final DateTime? createAt;
  final DateTime? updateAt;
}