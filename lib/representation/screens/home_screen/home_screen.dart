import 'dart:io';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';
import 'package:travel_app/core/extensions/date_time_format.dart';
import 'package:travel_app/representation/screens/form_login/login_screen.dart';
import 'package:travel_app/representation/screens/on_leave_screen.dart';
import 'package:travel_app/representation/screens/task_screen/task_screen.dart';
import 'package:travel_app/representation/screens/users_screen/user_detail_screen.dart';

import '../../../Data/models/task_model.dart';
import '../../../Data/models/user_model.dart';
import '../../../core/constants/dismension_constants.dart';
import '../../../core/helpers/asset_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../../core/helpers/local_storage_helper.dart';
import '../../../services/task_services.dart';
import '../../../services/user_services.dart';
import '../../widgets/app_bar_container.dart';
import '../../widgets/list_task.dart';
import '../select_date_screen.dart';
import '../task_screen/task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskModal taskModalEmty = new TaskModal();
  File? file;
  String? imageUser;
  UserModal userModal = new UserModal();

  @override
  Widget build(BuildContext context) {
    var userLogin = LocalStorageHelper.getValue('userLogin');
    print(userLogin);
    return AppBarContainerWidget(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: kMinPadding),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Xin Chào",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                                fontWeight: FontWeight.bold, fontSize: 16));
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
                    print(userModal.imageUser);
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
        child: Column(children: [
          SizedBox(
            height: kDefaultPadding * 3,
          ),
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
                    return _buildItemCategory(Icon(FontAwesomeIcons.plus),
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
                    }, 'Điểm danh');
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
                    print(listDate);
                    return _buildItemCategory(Icon(FontAwesomeIcons.calendar),
                        () {
                      Navigator.of(context).pushNamed(
                          SelectDateScreen.routeName,
                          arguments: listDate);
                    }, 'Lịch làm việc');
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )),
              Expanded(
                child: _buildItemCategory(Icon(FontAwesomeIcons.list), () {
                  Navigator.of(context).pushNamed(TaskDetail.routeName,
                      arguments: taskModalEmty);
                }, 'Thêm task'),
              ),
              Expanded(
                child: _buildItemCategory(Icon(FontAwesomeIcons.userLargeSlash),
                    () async {
                  Navigator.of(context).pushNamed(OnLeaveScreen.routeName);
                }, 'Đăng ký nghỉ phép'),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: (() {
              Navigator.of(context).pushNamed(TaskScreen.routeName, arguments: true);
            }),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Danh sách task của bạn",
                    style: TextStyleCustom.h2TextPrimary,
                  ),
                  Icon(
                    FontAwesomeIcons.arrowRight,
                    size: 16,
                    color: ColorPalette.primaryColor,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: getAllTasks(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.hasData) {
                  final taskModal = snapshot.data!;
                  var userLogin = LocalStorageHelper.getValue('userLogin');
                  List<TaskModal> listTasks = [];
                  for (var e in taskModal) {
                    if (e.userId == userLogin["id"]) {
                      listTasks.add(e);
                    }
                  }
                  listTasks.sort((a, b) {
                  var adate = a.createAt;
                  var bdate = b.createAt;
                  return -adate!.compareTo(bdate!);
                });

                  return ListView(
                    children: listTasks
                        .map(((e) => ListTask(
                              taskModal: e,
                            )))
                        .toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ]));
  }

  Widget _buildItemCategory(Icon icon, Function() onTap, String title) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(vertical: kMediumPadding, horizontal: 24),
            decoration: BoxDecoration(
                color: ColorPalette.secondColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(kItemPadding)),
            child: icon,
          ),
          SizedBox(
            height: kItemPadding,
          ),
          Text(
            title,
            style: TextStyleCustom.nomalTextPrimary,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
