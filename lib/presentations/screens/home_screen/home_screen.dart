import 'dart:io';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helpers/extensions/date_time_format.dart';
import 'package:travel_app/presentations/screens/form_login/login_screen.dart';
import 'package:travel_app/presentations/screens/on_leave_screen.dart';
import 'package:travel_app/presentations/screens/task_screen/task_screen.dart';
import 'package:travel_app/presentations/screens/users_screen/user_detail_screen.dart';
import 'package:travel_app/services/task_services.dart';

import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';
import 'package:travel_app/services/user_services.dart';
import '../../widgets/app_bar_container.dart';
import '../select_date_screen.dart';
import '../task_screen/task_detail_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskModal taskModalEmty = TaskModal();
  File? file;
  String? imageUser;
  UserModal userModal = UserModal();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var userLogin = LocalStorageHelper.getValue('userLogin');

    return AppBarContainerWidget(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: kMinPadding),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Xin Chào,",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    height: kMinPadding,
                  ),
                  StreamBuilder(
                    stream: getAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      if (snapshot.hasData) {
                        final userModal = snapshot.data!;
                        var userLogin =
                            LocalStorageHelper.getValue('userLogin');
                        var userName;
                        for (var e in userModal) {
                          if (e.id == userLogin["id"]) {
                            userName = e.name;
                          }
                        }
                        return Text(userName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () async {
                  if (await confirm(
                    context,
                    title: const Text('Đăng xuất'),
                    content: Text("Xác nhận đăng xuất khỏi app"),
                    textOK: const Text('Xác nhận'),
                    textCancel: const Text('Thoát'),
                  )) {
                    LocalStorageHelper.setValue('checkLogin', false);
                    Navigator.pushReplacementNamed(
                        context, FormLoginScreen.routeName);
                  }
                  ;
                },
                child: Icon(
                  FontAwesomeIcons.rightToBracket,
                  size: kDefaultIconSize,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(UserDetail.routeName, arguments: userModal);
                  },
                  child: StreamBuilder(
                    stream: getAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      if (snapshot.hasData) {
                        final projectModal = snapshot.data!;
                        userModal = findUserById(userLogin["id"], projectModal);
                        return userModal.imageUser != null
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(userModal.imageUser!),
                                        fit: BoxFit.cover)),
                              )
                            : ImageHelper.loadFromAsset(AssetHelper.user,
                                radius: BorderRadius.circular(20));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        titleString: "home",
        isHomePage: true,
        child: ListView(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  if (snapshot.hasData) {
                    final projectModal = snapshot.data!;
                    return _buildItemCategory(
                        Icon(FontAwesomeIcons.plus, color: Colors.white),
                        () async {
                      if (await confirm(
                        context,
                        title: const Text('Điểm danh'),
                        content: Text('Xác nhận điểm danh ngày hôm nay: ' +
                            "${formatDate(DateTime.now())}"),
                        textOK: const Text('Xác nhận'),
                        textCancel: const Text('Thoát'),
                      )) {
                        var user = findUserById(userLogin["id"], projectModal);
                        if (user != [] && checkDate(DateTime.now(), user)) {
                          var today = DateTime.now();
                          var listDate = user.checkIn ?? [];
                          listDate.add(today);
                          await updateUserCheckIn(
                              id: userLogin["id"].toString(),
                              checkIn: listDate,
                              updateAt: DateTime.now());
                          await EasyLoading.showSuccess("Điểm danh thành công");
                        } else {
                          await EasyLoading.showError(
                              "Bạn đã điểm danh ngày hôm nay");
                        }
                      }
                      return print('pressedCancel');
                    }, 'Điểm danh', theme);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )),
              Expanded(
                  child: StreamBuilder(
                stream: getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  if (snapshot.hasData) {
                    final projectModal = snapshot.data!;
                    userModal = findUserById(userLogin["id"], projectModal);
                    var user = userModal;

                    List<DateTime> listDate = [];

                    if (user.checkIn != null) {
                      for (var e in user.checkIn!) {
                        listDate.add(e.toDate());
                      }
                    }
                    return _buildItemCategory(
                        Icon(
                          FontAwesomeIcons.calendar,
                          color: Colors.white,
                        ), () {
                      Navigator.of(context).pushNamed(
                          SelectDateScreen.routeName,
                          arguments: listDate);
                    }, 'Lịch làm việc', theme);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )),
              Expanded(
                child: _buildItemCategory(
                    Icon(FontAwesomeIcons.list, color: Colors.white), () {
                  Navigator.of(context).pushNamed(TaskDetail.routeName,
                      arguments: taskModalEmty);
                }, 'Thêm công việc', theme),
              ),
              Expanded(
                child: _buildItemCategory(
                    Icon(
                      FontAwesomeIcons.userLargeSlash,
                      color: Colors.white,
                    ), () async {
                  Navigator.of(context).pushNamed(OnLeaveScreen.routeName);
                }, 'Đăng ký nghỉ phép', theme),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: (() {
              Navigator.of(context)
                  .pushNamed(TaskScreen.routeName, arguments: true);
            }),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      "Công việc trong tháng này của bạn",
                      style: theme.textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.arrowRight,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: StreamBuilder(
              stream: getAllTasks(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.hasData) {
                  final taskModal = snapshot.data!;
                  var time = DateTime.now();

                  var userLogin = LocalStorageHelper.getValue('userLogin');
                  List<TaskModal> listTask = [];
                  for (var e in taskModal) {
                    if (e.userId == userLogin["id"] &&
                        e.createAt!.isAfter(DateTime(time.year, time.month)) ==
                            true) {
                      listTask.add(e);
                    }
                  }

                  List success = [];
                  List codding = [];
                  List onHold = [];
                  List review = [];
                  for (var e in listTask) {
                    if (e.status == "Done") {
                      success.add(e.status);
                    }
                    if (e.status == "Coding") {
                      codding.add(e.status);
                    }
                    if (e.status == "HoldOn") {
                      onHold.add(e.status);
                    }
                    if (e.status == "Review") {
                      review.add(e.status);
                    }
                  }
                  return InkWell(
                      onTap: (() {
                        Navigator.of(context)
                            .pushNamed(TaskScreen.routeName, arguments: true);
                      }),
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          _buildItem6(success.length.toString(), "Hoàn thành",
                              theme, Colors.orange),
                          _buildItem4(codding.length.toString(), "Đang code",
                              theme, Colors.green),
                          _buildItem4(onHold.length.toString(), "Tạm hoãn",
                              theme, Colors.yellow),
                          _buildItem6(review.length.toString(), "Chờ duyệt",
                              theme, Colors.red),
                        ],
                      ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ]));
  }


  Widget _buildItemCategory(
      Icon icon, Function() onTap, String title, ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: kMediumPadding, horizontal: 24),
              decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(kItemPadding)),
              child: icon,
            ),
            SizedBox(
              height: kItemPadding,
            ),
            Text(
              title,
              style: theme.textTheme.subtitle2!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  _buildItem4(String number, String title, ThemeData theme, Color color) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              number,
              style: theme.textTheme.headline5,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              title,
              // style: theme.textTheme.headline3,
            )
          ])),
    );
  }

  _buildItem6(String number, String title, ThemeData theme, Color color) {
    return AspectRatio(
      aspectRatio: 3 / 3,
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              number,
              style: theme.textTheme.headline5,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              title,
              // style: theme.textTheme.headline3,
            )
          ])),
    );
  }
}
