import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';
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
    return AppBarContainerWidget(
        isHomePage: false,
        child: Column(children: [
          Row(children: const [
            Expanded(flex: 3, child: SearchInput()),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 2,
                child: SelectOption(list: list,))
          ]),
        ]));
  }
}

const List<String> list = <String>[
  'Tên',
  'Tên nhân viên',
  'Trạng thái',
  'Cấp độ'
];
