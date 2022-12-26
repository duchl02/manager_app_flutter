import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/constants/dismension_constants.dart';
import '../../widgets/app_bar_container.dart';

class StaffsScreen extends StatefulWidget {
  const StaffsScreen({super.key});

  static const routeName = "/staff_screen";

  @override
  State<StaffsScreen> createState() => _StaffsScreenState();
}

class _StaffsScreenState extends State<StaffsScreen> {
  final textController = TextEditingController();

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection("user")
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => User.fromJson(doc.data())).toList());

  Future<User?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection("user")
        .doc("09V8nAbixt9RZhGITONI");
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
    return null;
  }

  Future createUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection("user").doc();

    final user =
        User(id: docUser.id, name: name, age: 21, birthday: DateTime.now());

    // docUser.update({'name': "duc", 'age': FieldValue.delete()});

    // docUser.delete();

    final json = user.toJson();

    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return
        // return AppBarContainerWidget(
        //     titleString: "Nhân viên",
        //     isHomePage: false,
        //     titleCount: "0",
        //     description: "Danh sách nhân viên",
        //     child: Column(children: [
        //       SizedBox(
        //         height: kDefaultPadding,
        //       ),
        //       StreamBuilder(
        //         stream: readUsers(),
        //         builder: (context, snapshot) {
        //           if (snapshot.hasError) {
        //             return Text("${snapshot.error}");
        //           }
        //           if (snapshot.hasData) {
        //             print("122");
        //             final users = snapshot.data!;
        //             return ListView(
        //               children: users.map(buildUser).toList(),
        //             );
        //           } else {
        //             print("321");
        //             return Center(child: CircularProgressIndicator());
        //           }
        //         },
        //       )
        //     ]));
        Scaffold(
      body: StreamBuilder(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          if (snapshot.hasData) {
            print("122");
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            print("321");
            return Center(child: CircularProgressIndicator());
          }
        },
        // future: readUser(),
        // builder: (context, snapshot) {
        //   if (snapshot.hasError) {
        //     return Text("${snapshot.error}");
        //   }
        //   if (snapshot.hasData) {
        //     final user = snapshot.data!;
        //     return user == null
        //         ? Center(child: Text("no user"))
        //         : buildUser(user);
        //   } else {
        //     print("321");
        //     return Center(child: CircularProgressIndicator());
        //   }
        // },
      ),
      appBar: AppBar(title: TextField(controller: textController), actions: [
        IconButton(
            onPressed: (() {
              final name = textController.text;
              createUser(name: name);
              print(name);
            }),
            icon: Icon(Icons.add))
      ]),
    );
  }
}

Widget buildUser(User user) => ListTile(
      leading: CircleAvatar(child: Text("${user.age}")),
      title: Text(user.name ?? "hello world"),
      subtitle: Text(user.birthday.toIso8601String()),
    );

class User {
  String id;
  final String? name;
  final int age;
  final DateTime birthday;

  User(
      {this.id = '',
       this.name,
      required this.age,
      required this.birthday});

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "age": age, "birthday": birthday};

  static User fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      age: json['age'],
      birthday: (json['birthday'] as Timestamp).toDate());
}
