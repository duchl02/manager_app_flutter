import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/representation/screens/task_screen/task_detail_screen.dart';
import 'package:travel_app/services/user_services.dart';

import '../../core/constants/text_style.dart';
import '../../core/extensions/date_time_format.dart';

class ListTask extends StatelessWidget {
  ListTask({
    Key? key,
    this.onTapTask,
    required this.taskModal,
  }) : super(key: key);

  final Function? onTapTask;
  final TaskModal taskModal;
  String statusDisplay = "";

  @override
  Widget build(BuildContext context) {
    if (taskModal.status == "S1") {
      statusDisplay = "Coding";
    } else if (taskModal.status == "S3") {
      statusDisplay = "In Progress";
    } else if (taskModal.status == "S2") {
      statusDisplay = "HoldOn";
    } else if (taskModal.status == "S4") {
      statusDisplay = "Done";
    }
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
            StreamBuilder(
              stream: getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.hasData) {
                  final userModal = snapshot.data!;
                  String name =
                      findUserById(taskModal.userId, userModal).name ?? "null";
                  return Row(
                    children: [
                      Text("Người tạo: "),
                      Text(name),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text("Trạng thái : ", style: TextStyleCustom.smallText),
                Text(statusDisplay, style: TextStyleCustom.smallText),
                Spacer(),
                // Text("Hoàn thành: "),
                // Text("25/12/2022 "),
                Text("Ngày tạo: ", style: TextStyleCustom.smallText),
                Text(
                    taskModal.createAt != null
                        ? formatDate(taskModal.createAt)
                        : "null",
                    style: TextStyleCustom.smallText),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
