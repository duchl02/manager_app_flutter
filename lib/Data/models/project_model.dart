class ProjectModal {
  ProjectModal({
    this.name,
    this.id,
    this.shortName,
    this.description,
    this.createAt,
    this.updateAt,
  });

  final String? name;
  final String? id;
  final String? shortName;
  final String? description;
  final DateTime? createAt;
  final DateTime? updateAt;
}