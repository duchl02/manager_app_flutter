import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/dismension_constants.dart';
import '../../../core/helpers/asset_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../widgets/app_bar_container.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
        titleString: "Task",
        isHomePage: false,
        titleCount: "0",
        description: "Danh sách task",
        child: Column(children: const [
          SizedBox(
            height: kDefaultPadding,
          ),
        ]));
  }
}
