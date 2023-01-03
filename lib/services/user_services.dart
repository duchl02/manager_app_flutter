import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/services/task_services.dart';

import '../Data/models/user_model.dart';
import '../representation/screens/users_screen/users_screen.dart';

Stream<List<UserModal>> getAllUsers() {
  var data = FirebaseFirestore.instance.collection("users").snapshots().map(
      (snapshots) =>
          snapshots.docs.map((doc) => UserModal.fromJson(doc.data())).toList());
  return data;
}

// CollectionReference _collectionRef =
//     FirebaseFirestore.instance.collection("users");
// List getdtaa() {
//   StreamBuilder(
//     stream: getAllTasks(),
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return Text("${snapshot.error}");
//       }
//       if (snapshot.hasData) {
//         final taskModal = snapshot.data!;
//         currentTaskData = taskModal;
//         print("object--------------------------------");
//         return taskModal ;
//       } else {
//         return Center(child: CircularProgressIndicator());
//       }
//     },
//   );
// }

List<Object?> userData = [];
List<UserModal> currentUserData = [];

// Future<List<Object?>> getAllDataUser(
// ) async {
//   QuerySnapshot querySnapshot = await _collectionRef.get();
//   userData = querySnapshot.docs.map((doc) => doc.data()).toList();
//   print(userData);
//   currentUserData = userData.toList();
//   return userData;
//   // print(data.toString());
// }
// List<UserModal> searchUser(name, category, list) {
//   print(name);
//   print(category);
//   List<UserModal> data = list;
//   List<UserModal> listSearch = [];
//   data.forEach((element) {
//     if (category == "Tên" && element.name.toString().contains(name)) {
//       listSearch.add(element);
//     }
//     if ('Tên nhân viên' == category &&
//         element.users.toString().contains(name)) {
//       listSearch.add(element);
//     }
//     if ("Tên task" == category && element.tasks.toString().contains(name)) {
//       listSearch.add(element);
//     }
//     if ("Tên ngắn" == category && element.shortName.toString().contains(name)) {
//       listSearch.add(element);
//     }
//   });
//   return listSearch;
// }

Future createUser(
    {name,
    userName,
    password,
    birthday,
    address,
    idNumber,
    phoneNumber,
    position,
    email,
    checkIn,
    projects,
    tasks,
    createAt,
    updateAt}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc();

  final userModal = UserModal(
      id: docUser.id,
      name: name,
      userName: userName,
      password: password,
      birthday: birthday,
      address: address,
      idNumber: idNumber,
      phoneNumber: phoneNumber,
      position: position,
      email: email,
      checkIn: checkIn,
      projects: projects,
      tasks: tasks,
      createAt: createAt ?? DateTime.now(),
      updateAt: updateAt ?? DateTime.now());

  final json = userModal.toJson();

  await docUser.set(json);
}

Future updateUser(
    {id,name,
    userName,
    password,
    birthday,
    address,
    idNumber,
    phoneNumber,
    position,
    email,
    checkIn,
    projects,
    tasks,
    createAt,
    updateAt}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(id);

  final userModal = UserModal(
       id: docUser.id,
      name: name,
      userName: userName,
      password: password,
      birthday: birthday,
      address: address,
      idNumber: idNumber,
      phoneNumber: phoneNumber,
      position: position,
      email: email,
      checkIn: checkIn,
      projects: projects,
      tasks: tasks,
      createAt: createAt ?? DateTime.now(),
      updateAt: updateAt ?? DateTime.now());

  final json = userModal.toJson();

  await docUser.update(json);
}

Future deleteUser(id) async {
  print(id);
  final docUser = FirebaseFirestore.instance.collection("users").doc(id);
  await docUser.delete();
}
