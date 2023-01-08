import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/project_model.dart';

import '../../Data/models/project_model.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/text_style.dart';
import '../../core/extensions/date_time_format.dart';
import '../screens/project_screen/project_detail.dart';

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
    return InkWell(
      onTap: (() {
        Navigator.of(context)
            .pushNamed(ProjectDetail.routeName, arguments: projectModal);
      }),
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: ColorPalette.secondColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(projectModal.name!, style: TextStyleCustom.nomalTextPrimary),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text("Tên ngắn gọn: "),
                Text(projectModal.shortName ?? "null"),
                Spacer(),
                Text("Ngày tạo: ", style: TextStyleCustom.smallText),
                Text(
                    projectModal.createAt != null
                        ? formatDate(projectModal.createAt)
                        : "null",
                    style: TextStyleCustom.smallText),
                // Text("Độ ưu tiên: ", style: TextStyleCustom.smallText),
                // Text(projectModal.priority ?? "null",
                //     style: TextStyleCustom.smallText),
                // Text("Ngày tạo: ", style: TextStyleCustom.smallText),
                // Text("23/12/2022", style: TextStyleCustom.smallText),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text("Mô tả : ", style: TextStyleCustom.smallText),
                Text(projectModal.description ?? "null",
                    style: TextStyleCustom.smallText),
                Spacer(),
                // Text("Hoàn thành: "),
                // Text("25/12/2022 "),
                
              ],
            )
          ]),
        ),
      ),
    );
  }
}
