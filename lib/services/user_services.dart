
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/Data/models/project_model.dart';
import 'package:travel_app/Data/models/user_model.dart';


Stream<List<UserModal>> getAllUsers() {
  var data = FirebaseFirestore.instance.collection("users").snapshots().map(
      (snapshots) =>
          snapshots.docs.map((doc) => UserModal.fromJson(doc.data())).toList());
  return data;
}

List<Object?> userData = [];
List<UserModal> currentUserData = [];

List<UserModal> searchUser(
    name, category, list, List<ProjectModal> listProject) {
  List<UserModal> data = list;
  List<UserModal> listSearch = [];
  String _projectId = "";
  ProjectModal _project = ProjectModal();
  for (var e in listProject) {
    if (e.name.toString().toLowerCase().contains(name)) {
      _project = e;
      print(e.name);
    }
  }
  data.forEach((element) {
    if (category == "project") {
      for (var e in _project.users!) {
        if (element.id == e) {
          print("-----------------");
          listSearch.add(element);
        }
      }
    }
    if ('name' == category &&
        element.name.toString().toLowerCase().contains(name)) {
      listSearch.add(element);
    }
    if ("userName" == category &&
        element.userName.toString().toLowerCase().contains(name)) {
      listSearch.add(element);
    }
    if ("phoneNumber" == category &&
        element.phoneNumber.toString().contains(name)) {
      listSearch.add(element);
    }
  });
  return listSearch;
}

UserModal findUserById(name, List<UserModal> list) {
  List<UserModal> data = list;
  UserModal user = UserModal();
  for (var e in data) {
    if (e.id.toString().contains(name)) {
      user = e;
    }
  }
  return user;
}

bool checkDate(DateTime date, UserModal modal) {
  var check = true;
  for (var e in modal.checkIn!) {
    if (date.year == e.toDate().year &&
        date.month == e.toDate().month &&
        date.day == e.toDate().day) {
      check = false;
      break;
    }
  }
  return check;
}

Future createUser(
    {name,
    userName,
    password,
    birthday,
    address,
    idNumber,
    phoneNumber,
    imageUser,
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
      imageUser: imageUser,
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
    {id,
    name,
    userName,
    password,
    birthday,
    address,
    idNumber,
    phoneNumber,
    position,
    email,
    imageUser,
    checkIn,
    projects,
    tasks,
    createAt,
    updateAt}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(id);

  final userModal = UserModal(
      id: docUser.id,
      name: name,
      imageUser: imageUser,
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

Future updateUserCheckIn({id, checkIn, updateAt}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(id);

  final userModal = UserModal(
      id: docUser.id, checkIn: checkIn, updateAt: updateAt ?? DateTime.now());

  final json = userModal.toJson();

  await docUser.update({
    "id": id,
    "checkIn": checkIn,
  });
}

Future deleteUser(id) async {
  print(id);
  final docUser = FirebaseFirestore.instance.collection("users").doc(id);
  await docUser.delete();
}
