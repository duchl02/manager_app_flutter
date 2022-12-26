import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/representation/screens/home_screen/home_screen.dart';
import 'package:travel_app/representation/screens/task_screen/task_detail_screen.dart';
import 'package:travel_app/representation/screens/task_screen/task_screen.dart';

import '../../core/constants/text_style.dart';

class ListTask extends StatelessWidget {
  const ListTask({
    Key? key,
    this.onTapTask,
    required this.taskModal,
  }) : super(key: key);

  final Function? onTapTask;
  final TaskModal taskModal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.of(context)
            .pushNamed(TaskDetail.routeName, arguments: taskModal);
      }),
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(taskModal.name!, style: TextStyleCustom.nomalTextPrimary),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text("Người tạo: "),
                Text(taskModal.userId!),
                Spacer(),
                Text("Độ ưu tiên: ", style: TextStyleCustom.smallText),
                Text("1", style: TextStyleCustom.smallText),
                // Text("Ngày tạo: ", style: TextStyleCustom.smallText),
                // Text("23/12/2022", style: TextStyleCustom.smallText),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text("Trạng thái : ", style: TextStyleCustom.smallText),
                Text("Coding", style: TextStyleCustom.smallText),
                Spacer(),
                // Text("Hoàn thành: "),
                // Text("25/12/2022 "),
                Text("Ngày tạo: ", style: TextStyleCustom.smallText),
                Text("23/12/2022", style: TextStyleCustom.smallText),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
