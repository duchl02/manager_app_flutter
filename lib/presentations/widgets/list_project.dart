import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/project_model.dart';

import '../features/project/project_detail.dart';

class ListProject extends StatelessWidget {
  const ListProject({
    Key? key,
    this.onTapProject,
    required this.projectModal,
  }) : super(key: key);

  final Function? onTapProject;
  final ProjectModal projectModal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: (() {
        Navigator.of(context)
            .pushNamed(ProjectDetail.routeName, arguments: projectModal);
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            projectModal.name!,
            style: theme.textTheme.subtitle1,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Tên ngắn gọn: ${projectModal.shortName}"),
            Text("Mô tả: ${projectModal.description}")
          ]),
        ),
      ),
    );
  }
}
