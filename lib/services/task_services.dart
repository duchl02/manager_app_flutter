import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/task_model.dart';

import '../representation/screens/users_screen/users_screen.dart';

Stream<List<TaskModal>> getAllTasks() {
  var data = FirebaseFirestore.instance.collection("tasks").snapshots().map(
      (snapshots) =>
          snapshots.docs.map((doc) => TaskModal.fromJson(doc.data())).toList());
  return data;
}

CollectionReference taskDb =
    FirebaseFirestore.instance.collection("tasks");

List<Object?> taskData = [];
List<TaskModal> currentTaskData = [];

// Future<List<Object?>> getAllDataTask(
// ) async {
//   QuerySnapshot querySnapshot = await _collectionRef.get();
//   taskData = querySnapshot.docs.map((doc) => doc.data()).toList();
//   print(taskData);
//   currentTaskData = taskData.toList();
//   return taskData;
//   // print(data.toString());
// }
List<TaskModal> searchTask(name, category, list) {
  print(name);
  print(category);
  List<TaskModal> data = list;
  List<TaskModal> listSearch = [];
  data.forEach((element) {
    if ( category == "Tên" && element.name.toString().contains(name)) {
      listSearch.add(element);
    }
    if ('Tên nhân viên' == category && element.userId.toString().contains(name)) {
      listSearch.add(element);
    }
    if ("Trạng thái" == category && element.status.toString().contains(name)) {
      listSearch.add(element);
    }
    if ("Độ ưu tiên" == category && element.priority.toString().contains(name)) {
      listSearch.add(element);
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
