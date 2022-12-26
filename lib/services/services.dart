import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/task_model.dart';

import '../representation/screens/staffs_screen/staffs_screen.dart';

Stream<List<TaskModal>> getAllTasks() {
  var data = FirebaseFirestore.instance.collection("tasks").snapshots().map(
      (snapshots) =>
          snapshots.docs.map((doc) => TaskModal.fromJson(doc.data())).toList());
  // print("----------------------------");

  // var ndata = data.map((event) => event.map((e) => e));
  // print(ndata);

  return data;
}

// List<TaskModal>? allTasks() {
//   var data = FirebaseFirestore.instance.collection("tasks").snapshots().map(
//       (snapshots) =>
//           snapshots.docs.map((doc) => TaskModal.fromJson(doc.data())).toList());
//   // print("----------------------------");

//   // var ndata = data.map((event) => event.map((e) => e));
//   // print(ndata);
//   if (data != null) {

//     return data.map((event) => event);
//   } else {
//     return null;
//   }
// }
// Stream<List<User>> readUsers() =>
//     FirebaseFirestore.instance.collection("user").snapshots().map((snapshots) =>
//         snapshots.docs.map((doc) => User.fromJson(doc.data())).toList());
// Stream<List<TaskModal>> getAllTasks() =>
//     FirebaseFirestore.instance.collection("tasks").snapshots().map((snapshots) =>
//         snapshots.docs.map((doc) => TaskModal.fromJson(doc.data())).toList());

// Future<TaskModal?> getTask() async {
//   final docUser = FirebaseFirestore.instance.collection("tasks").doc("ducid");
//   final snapshot = await docUser.get();
//   if (snapshot.exists) {
//     // print(snapshot.data());
//     return TaskModal.fromJson(snapshot.data()!);
//   }
//   return null;
// }

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("tasks");

Future<void> getTask() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  print("------------------");
  print(allData);
}

// Future<List<TaskModal>> getTask() async {
//   final docUser =
//       FirebaseFirestore.instance.collection("tasks").get().toString();
//   print(docUser);
//   // final snapshot = await docUser.get();

//   // if (snapshot.exists) {
//   //   // print(snapshot.data());
//   //   return TaskModal.fromJson(snapshot.data()!);
//   // }
//   return null;
// }


// Stream<List<User>> readUsers() => FirebaseFirestore.instance
//     .collection("tasks")
//     .snapshots()
//     .map((snapshots) =>
//         snapshots.docs.map((doc) => User.fromJson(doc.data())).toList());

// Future<User?> readUser() async {
//   final docUser =
//       FirebaseFirestore.instance.collection("user").doc("09V8nAbixt9RZhGITONI");
//   final snapshot = await docUser.get();
//   if (snapshot.exists) {
//     return User.fromJson(snapshot.data()!);
//   }
//   return null;
// }

// Future createUser({required String name}) async {
//   final docUser = FirebaseFirestore.instance.collection("user").doc();

//   final user =
//       User(id: docUser.id, name: name, age: 21, birthday: DateTime.now());

//   // docUser.update({'name': "duc", 'age': FieldValue.delete()});

//   // docUser.delete();

//   final json = user.toJson();

//   await docUser.set(json);
// }

// Widget buildUser(User user) => ListTile(
//       leading: CircleAvatar(child: Text("${user.age}")),
//       title: Text(user.name),
//       subtitle: Text(user.birthday.toIso8601String()),
//     );

// class User {
//   String id;
//   final String name;
//   final int age;
//   final DateTime birthday;

//   User(
//       {this.id = '',
//       required this.name,
//       required this.age,
//       required this.birthday});

//   Map<String, dynamic> toJson() =>
//       {"id": id, "name": name, "age": age, "birthday": birthday};

//   static User fromJson(Map<String, dynamic> json) => User(
//       name: json['name'],
//       age: json['age'],
//       birthday: (json['birthday'] as Timestamp).toDate());
// }
