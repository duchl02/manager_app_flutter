import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/services/project_services.dart';
import 'package:travel_app/services/user_services.dart';

import '../representation/screens/users_screen/users_screen.dart';

Stream<List<TaskModal>> getAllTasks() {
  var data = FirebaseFirestore.instance.collection("tasks").snapshots().map(
      (snapshots) =>
          snapshots.docs.map((doc) => TaskModal.fromJson(doc.data())).toList());
  return data;
}

CollectionReference taskDb = FirebaseFirestore.instance.collection("tasks");

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
List<TaskModal> searchTask(name, category, list, listUser, listProject) {
  print("-----------------------------------------------");
  List<TaskModal> data = list;
  List<TaskModal> listSearch = [];
  data.forEach((element) {
    if (category == "name" &&
        element.name.toString().toLowerCase().contains(name)) {
      listSearch.add(element);
    }
    if ('userName' == category) {
      var listUserName = [];
      for (var e in data) {
        var userName = findUserById(e.userId, listUser).name ?? "##";
        listUserName.add(userName);
      }
      for (var e in listUserName) {
        if (e.toLowerCase().contains(name) && name != '') {
          if (listSearch.contains(element)) {
          } else {
            print("0000000000000000000000");
            listSearch.add(element);
          }
        }
      }
    }
    if ("status" == category &&
        element.status.toString().toLowerCase().contains(name)) {
      listSearch.add(element);
    }
    if ("project" == category) {
      var projectName = findProjectById(name, listProject).name ?? "##";
      if (element.priority.toString().toLowerCase().contains(projectName)) {
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
