import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StaffsScreen extends StatefulWidget {
  const StaffsScreen({super.key});

  static const routeName = "/staff_screen";

  @override
  State<StaffsScreen> createState() => _StaffsScreenState();
}

class _StaffsScreenState extends State<StaffsScreen> {
  final textController = TextEditingController();

  Future createUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection("user").doc('duc_id');

    final json = {"name": name, "age": 21, "birthday": DateTime(2002, 3, 15)};

    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
