import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/Data/models/project_model.dart';
import 'package:travel_app/services/user_services.dart';


Stream<List<ProjectModal>> getAllProjects() {
  var data = FirebaseFirestore.instance.collection("projects").snapshots().map(
      (snapshots) => snapshots.docs
          .map((doc) => ProjectModal.fromJson(doc.data()))
          .toList());
  return data;
}

List<Object?> projectData = [];
List<ProjectModal> currentProjectData = [];

List<ProjectModal> searchProject(name, category, list, listUser) {
  List<ProjectModal> data = list;
  List<ProjectModal> listSearch = [];
  data.forEach((element) {
    if (category == "name" &&
        element.name.toString().toLowerCase().contains(name)) {
      listSearch.add(element);
    }
    if ('userName' == category) {
      String _userName = '';
      List _listNameUser = [];
      for (var e in element.users!) {
        _userName = findUserById(e, listUser).name ?? "##";

        _listNameUser.add(_userName);
      }
      for (var e in _listNameUser) {
        if (e.toLowerCase().contains(name)) {
          listSearch.add(element);
          break;
        }
      }
    }
    if ("shortName" == category &&
        element.shortName.toString().toLowerCase().contains(name)) {
      listSearch.add(element);
    }
  });
  return listSearch;
}

Future createProject(
    {name, description, shortName, users, tasks, createAt, updateAt}) async {
  final docProject = FirebaseFirestore.instance.collection("projects").doc();

  final projectModal = ProjectModal(
      id: docProject.id,
      name: name,
      description: description,
      shortName: shortName,
      users: users,
      tasks: tasks,
      createAt: createAt ?? DateTime.now(),
      updateAt: updateAt ?? DateTime.now());

  final json = projectModal.toJson();

  await docProject.set(json);
}

Future updateProject(
    {id,
    name,
    description,
    shortName,
    users,
    tasks,
    createAt,
    updateAt}) async {
  final docProject = FirebaseFirestore.instance.collection("projects").doc(id);

  final projectModal = ProjectModal(
      id: id,
      name: name,
      description: description,
      shortName: shortName,
      users: users,
      tasks: tasks,
      createAt: createAt ?? DateTime.now(),
      updateAt: updateAt ?? DateTime.now());

  final json = projectModal.toJson();

  await docProject.update(json);
}

Future deleteProject(id) async {
  print(id);
  final docProject = FirebaseFirestore.instance.collection("projects").doc(id);
  await docProject.delete();
}

ProjectModal findProjectById(name, List<ProjectModal> list) {
  List<ProjectModal> data = list;
  ProjectModal user = ProjectModal();
  for (var e in data) {
    if (e.id.toString().contains(name)) {
      user = e;
    }
  }
  return user;
}
