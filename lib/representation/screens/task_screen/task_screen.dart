import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/list_task.dart';
import 'package:travel_app/representation/widgets/search_input.dart';
import 'package:travel_app/representation/widgets/select_option.dart';

import '../../../core/constants/dismension_constants.dart';
import '../../../core/constants/textstyle_ext.dart';
import '../../../core/helpers/asset_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../widgets/app_bar_container.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task (12)"),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(children: [
          SearchInput(),
          SizedBox(
            height: 5,
          ),
          Row(children: const [
            Expanded(
              flex: 3,
              child: SelectOption(
                list: list,
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
              children: const [
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}

const List<String> list = <String>[
  'Tên',
  'Tên nhân viên',
  'Trạng thái',
  'Độ ưu tiên'
];
