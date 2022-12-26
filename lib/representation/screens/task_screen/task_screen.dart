import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';
import 'package:travel_app/representation/screens/task_screen/task_detail_screen.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/list_task.dart';
import 'package:travel_app/representation/widgets/search_input.dart';
import 'package:travel_app/representation/widgets/select_option.dart';

import '../../../Data/models/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
  });

  static const routeName = '/task_screen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
  // final TaskModal taskModal;
}

class _TaskScreenState extends State<TaskScreen> {
  // String dropdownValue = list.first;

  final List<TaskModal> listTasks = [
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
    TaskModal(
      name: "Task",
      userId: "user_id",
    ),
  ];

  final TaskModal taskModalEmty  = new TaskModal();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task (12)"),
        backgroundColor: ColorPalette.primaryColor,
        actions: [
          InkWell(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  FontAwesomeIcons.plus,
                )),
            onTap: () {
              Navigator.of(context).pushNamed(TaskDetail.routeName,arguments:taskModalEmty );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(children: [
          SearchInput(),
          SizedBox(
            height: 5,
          ),
          Row(children: [
            Expanded(
              flex: 3,
              child: SelectOption(
                list: _list,
                dropdownValue: _list[0],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(flex: 2, child: ButtonWidget(title: "Tìm kiếm"))
          ]),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: listTasks.map((e) => ListTask(taskModal: e)).toList(),
            ),
          ))
        ]),
      ),
    );
  }
}

const List<String> _list = <String>[
  'Tên',
  'Tên nhân viên',
  'Trạng thái',
  'Độ ưu tiên'
];
