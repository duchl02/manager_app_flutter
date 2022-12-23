import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/dismension_constants.dart';
import '../../../core/helpers/asset_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../widgets/app_bar_container.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
        titleString: "Dự án",
        isHomePage: false,
        titleCount: "0",
        description: "Danh sách dự án",
        child: Column(children: const [
          SizedBox(
            height: kDefaultPadding,
          ),
        ]));
  }
}
