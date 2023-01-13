import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/constants/color_constants.dart';
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
    final theme = Theme.of(context);

    return InkWell(
      onTap: (() {
        Navigator.of(context)
            .pushNamed(TaskDetail.routeName, arguments: taskModal);
      }),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.2),
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
                    // style: TextStyle(color: ColorPalette.text1Color),
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
                        // Text("Trạng thái : ", style: TextStyleCustom.smallText),
                        Text(
                          taskModal.status!,
                        ),
                        Spacer(),
                        // // Text("Hoàn thành: "),
                        // // Text("25/12/2022 "),
                        // Text("Ngày tạo: ", style: TextStyleCustom.smallText),
                        Text(
                          taskModal.createAt != null
                              ? formatDate(taskModal.createAt)
                              : "null",
                        ),
                      ],
                    )
                  ]),
                );
                // return Row(
                //   children: [
                //     Text("Người tạo: "),
                //     Text(_user.name ?? "null"),
                //     Spacer(),
                //     _user.imageUser != null
                //         ? Container(
                //             width: 24,
                //             height: 24,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(50),
                //                 image: DecorationImage(
                //                     image: NetworkImage(_user.imageUser!),
                //                     fit: BoxFit.cover)),
                //           )
                //         : SizedBox()
                //   ],
                // );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        // child: Padding(
        //   padding: EdgeInsets.all(10),
        //   child:
        //       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //     Row(
        //       children: [
        //         Text(taskModal.name!, style: TextStyleCustom.nomalTextPrimary),
        //         Spacer(),
        //       ],
        //     ),
        //     SizedBox(
        //       height: 6,
        //     ),
        //     StreamBuilder(
        //       stream: getAllUsers(),
        //       builder: (context, snapshot) {
        //         if (snapshot.hasError) {
        //           return Text("${snapshot.error}");
        //         }
        //         if (snapshot.hasData) {
        //           final _userModals = snapshot.data!;
        //           UserModal _user = findUserById(taskModal.userId, _userModals);
        //           return Row(
        //             children: [
        //               Text("Người tạo: "),
        //               Text(_user.name ?? "null"),
        //               Spacer(),
        //               _user.imageUser != null
        //                   ? Container(
        //                     width: 24,
        //                     height: 24,
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(50),
        //                           image: DecorationImage(
        //                               image: NetworkImage(_user.imageUser!),
        //                               fit: BoxFit.cover)),
        //                     )
        //                   : SizedBox()
        //             ],
        //           );
        //         } else {
        //           return Center(child: CircularProgressIndicator());
        //         }
        //       },
        //     ),
        //     SizedBox(
        //       height: 6,
        //     ),
        //     Row(
        //       children: [
        //         Text("Trạng thái : ", style: TextStyleCustom.smallText),
        //         Text(taskModal.status!, style: TextStyleCustom.smallText),
        //         Spacer(),
        //         // Text("Hoàn thành: "),
        //         // Text("25/12/2022 "),
        //         Text("Ngày tạo: ", style: TextStyleCustom.smallText),
        //         Text(
        //             taskModal.createAt != null
        //                 ? formatDate(taskModal.createAt)
        //                 : "null",
        //             style: TextStyleCustom.smallText),
        //       ],
        //     )
        //   ]),
        // ),
      ),
    );
  }
}
