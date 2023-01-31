import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/services/project_services.dart';
import 'package:travel_app/services/user_services.dart';


Stream<List<TaskModal>> getAllTasks() {
  var data = FirebaseFirestore.instance.collection("tasks").snapshots().map(
      (snapshots) =>
          snapshots.docs.map((doc) => TaskModal.fromJson(doc.data())).toList());
  return data;
}

CollectionReference taskDb = FirebaseFirestore.instance.collection("tasks");

List<Object?> taskData = [];
List<TaskModal> currentTaskData = [];
List<TaskModal> searchTask(name, category, list, listUser, listProject) {
  List<TaskModal> data = list;
  List<TaskModal> listSearch = [];
  data.forEach((element) {
    if (category == "name" &&
        element.name.toString().toLowerCase().contains(name)) {
      listSearch.add(element);
    }
    if ('userName' == category) {
      String _userName = findUserById(element.userId, listUser).name ?? "##";
      if (_userName.toLowerCase().contains(name)) {
        listSearch.add(element);
      }
    }
    if ("status" == category &&
        element.status.toString().toLowerCase().contains(name)) {
      listSearch.add(element);
    }
    if ("project" == category) {
      var projectName =
          findProjectById(element.projectId, listProject).name ?? "##";
      if (projectName.toLowerCase().contains(name)) {
        listSearch.add(element);
      }
    }
  });
  return listSearch;
}

Future createTask(
    {name,
    description,
    priority,
    status,
    projectId,
    userId,
    timeSuccess,
    createAt,
    updateAt}) async {
  final docTask = FirebaseFirestore.instance.collection("tasks").doc();

  final taskModal = TaskModal(
      id: docTask.id,
      name: name,
      description: description,
      priority: priority,
      status: status,
      projectId: projectId,
      userId: userId,
      timeSuccess: timeSuccess,
      createAt: createAt ?? DateTime.now(),
      updateAt: updateAt ?? DateTime.now());
  final json = taskModal.toJson();

  await docTask.set(json);
}

Future updateTask(
    {id,
    name,
    description,
    priority,
    status,
    projectId,
    userId,
    timeSuccess,
    createAt,
    updateAt}) async {
  final docTask = FirebaseFirestore.instance.collection("tasks").doc(id);

  final taskModal = TaskModal(
      id: id,
      name: name,
      description: description,
      priority: priority,
      status: status,
      projectId: projectId,
      userId: userId,
      timeSuccess: timeSuccess,
      createAt: createAt ?? DateTime.now(),
      updateAt: updateAt ?? DateTime.now());

  final json = taskModal.toJson();

  await docTask.update(json);
}

Future deleteTask(id) async {
  print(id);
  final docTask = FirebaseFirestore.instance.collection("tasks").doc(id);
  await docTask.delete();
}
