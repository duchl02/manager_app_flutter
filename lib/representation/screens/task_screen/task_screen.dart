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
import '../../../services/task_services.dart';

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
  // String dropdownValue = list.first

  @override
  void initState() {
    super.initState();
    category = _list[0];
    isSearch = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isSearch = false;
  }

  final TaskModal taskModalEmty = TaskModal();
  List<TaskModal> list = [];
  bool isSearch = false;
  late String category;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: getAllTasks(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            if (snapshot.hasData) {
              final taskModal = snapshot.data!;
              taskModal.map(
                (e) {},
              );
              return Text(
                "Task (" + taskModal.length.toString() + ")",
                // style: TextStyleCustom.h1Text,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        backgroundColor: ColorPalette.primaryColor,
        actions: [
          InkWell(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  FontAwesomeIcons.plus,
                )),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(TaskDetail.routeName, arguments: taskModalEmty);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(children: [
          SearchInput(
            controller: textEditingController,
            onChanged: (value) {
              setState(() {
                textEditingController.text = value;
              });
            },
          ),
          SizedBox(
            height: 5,
          ),
          Row(children: [
            Expanded(
              flex: 3,
              child: SelectOption(
                list: _list,
                dropdownValue: category,
                onChanged: ((p0) {
                  category = p0.toString();
                }),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 2,
                child: ButtonWidget(
                    title: "Tìm kiếm",
                    ontap: () {
                      var data;
                      setState(() {
                        if (isSearch == false) {
                          isSearch = true;
                        }
                        list = searchTask(textEditingController.text, category,
                            currentTaskData);
                      });
                    }))
          ]),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: isSearch == false
                  ? StreamBuilder(
                      stream: getAllTasks(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.hasData) {
                          final taskModal = snapshot.data!;
                          currentTaskData = taskModal;
                          // taskModal.map(
                          //   (e) {
                          //     print(e.show());
                          //   },
                          // );
                          return ListView(
                            children: taskModal
                                .map(((e) => ListTask(
                                      taskModal: e,
                                    )))
                                .toList(),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children:
                            list.map((e) => ListTask(taskModal: e)).toList(),
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
