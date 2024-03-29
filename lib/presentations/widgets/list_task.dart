import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/presentations/features/task/task_detail_screen.dart';
import 'package:travel_app/services/user_services.dart';

import '../../core/helpers/extensions/date_time_format.dart';

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
    final theme = Theme.of(context);
    String getStatus() {
      if (taskModal.status == "Coding") {
        return "Đang code";
      } else if (taskModal.status == "HoldOn") {
        return 'Tạm hoãn';
      } else if (taskModal.status == "Review") {
        return 'Chờ duyệt';
      } else if (taskModal.status == "Done") {
        return 'Hoàn thành';
      } else {
        return "null";
      }
    }

    return InkWell(
      onTap: (() {
        Navigator.of(context)
            .pushNamed(TaskDetail.routeName, arguments: taskModal);
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 6, bottom: 6),
          child: StreamBuilder(
            stream: getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              if (snapshot.hasData) {
                final _userModals = snapshot.data!;
                UserModal _user = findUserById(taskModal.userId, _userModals);
                return ListTile(
                  title: Text(
                    taskModal.name ?? "null",
                  ),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: NetworkImage(_user.imageUser ??
                                "https://t4.ftcdn.net/jpg/02/29/75/83/360_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  subtitle: Column(children: [
                    Row(
                      children: [
                        Text("Người tạo: "),
                        Text(_user.name ?? "null"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          getStatus(),
                        ),
                        Spacer(),
                        Text(
                          taskModal.createAt != null
                              ? formatDate(taskModal.createAt)
                              : "null",
                        ),
                      ],
                    )
                  ]),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
