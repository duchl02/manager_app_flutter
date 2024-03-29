import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/models/project_model.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/presentations/features/root/tabs/project_screen.dart';
import 'package:travel_app/services/project_services.dart';
import 'package:travel_app/services/task_services.dart';
import 'package:travel_app/services/user_services.dart';

import '../../Data/models/user_model.dart';
import '../../core/helpers/local_storage_helper.dart';
import '../screens/select_date_screen.dart';
import '../features/root/tabs/task_screen.dart';

class AppBarContainerWidget extends StatelessWidget {
  AppBarContainerWidget(
      {super.key,
      required this.child,
      this.title,
      this.implementLoading = true,
      this.titleString,
      this.implementTraveling = false,
      this.isHomePage = false,
      this.description,
      this.titleCount});

  final Widget child;
  final Widget? title;
  final bool implementLoading;
  final String? titleString;
  final bool implementTraveling;
  final bool? isHomePage;
  final String? description;
  final String? titleCount;
  UserModal userModal = new UserModal();

  @override
  Widget build(BuildContext context) {
    var userLogin = LocalStorageHelper.getValue('userLogin');
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            height: isHomePage! ? 180 : 120,
            width: double.infinity,
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 100,
              title: title ??
                  Row(
                    children: [
                      if (implementLoading && isHomePage!)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white),
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.black,
                              size: kDefaultIconSize,
                            ),
                          ),
                        ),
                      Expanded(
                          child: Center(
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(titleString ?? "",
                                      style: TextStyle(fontSize: 20)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(titleCount ?? "",
                                      style: TextStyle(fontSize: 20)),
                                ]),
                          ),
                          Text(description ?? "",
                              style: TextStyle(fontSize: 16)),
                        ]),
                      )),
                      if (implementTraveling)
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          padding: EdgeInsets.all(kDefaultPadding),
                          child: Icon(
                            FontAwesomeIcons.bars,
                            size: kDefaultPadding,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: ImageHelper.loadFromAsset(AssetHelper.icoOvalTop)),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child:
                          ImageHelper.loadFromAsset(AssetHelper.icoOvalBottom)),
                ],
              ),
            ),
          ),
          if (isHomePage!)
            Container(
              margin: EdgeInsets.only(top: 180),
              child: child,
              padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
            ),
          Container(
            margin: EdgeInsets.only(top: 120),
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    StreamBuilder(
                      stream: getAllUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.hasData) {
                          final projectModal = snapshot.data!;
                          userModal =
                              findUserById(userLogin["id"], projectModal);
                          var user = userModal;
                          var time = DateTime.now();

                          List<DateTime> listDate = [];

                          if (user.checkIn != null) {
                            for (var e in user.checkIn!) {
                              if (e.toDate().isAfter(
                                      DateTime(time.year, time.month)) ==
                                  true) {
                                listDate.add(e.toDate());
                              }
                            }
                          }
                          return InkWell(
                            onTap: (() {
                              Navigator.of(context).pushNamed(
                                  SelectDateScreen.routeName,
                                  arguments: listDate);
                            }),
                            child: Column(
                              children: [
                                Text(
                                  listDate.length.toString(),
                                  style: theme.textTheme.headline5!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Điểm danh",
                                  style: theme.textTheme.subtitle1!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    StreamBuilder(
                      stream: getAllTasks(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.hasData) {
                          final taskModal = snapshot.data!;
                          var userLogin =
                              LocalStorageHelper.getValue('userLogin');
                          List<TaskModal> listTasks = [];
                          var time = DateTime.now();

                          for (var e in taskModal) {
                            if (e.userId == userLogin["id"] &&
                                e.createAt!.isAfter(
                                        DateTime(time.year, time.month)) ==
                                    true) {
                              listTasks.add(e);
                            }
                          }
                          return InkWell(
                            onTap: (() {
                              Navigator.of(context).pushNamed(
                                  TaskScreen.routeName,
                                  arguments: true);
                            }),
                            child: Column(
                              children: [
                                Text(
                                  listTasks.length.toString(),
                                  style: theme.textTheme.headline5!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Công việc",
                                  style: theme.textTheme.subtitle1!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    StreamBuilder(
                      stream: getAllProjects(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.hasData) {
                          final taskModal = snapshot.data!;
                          var userLogin =
                              LocalStorageHelper.getValue('userLogin');
                          List<ProjectModal> listTasks = [];
                          for (var e in taskModal) {
                            for (var e2 in e.users!) {
                              if (e2 == userLogin["id"]) {
                                listTasks.add(e);
                              }
                            }
                          }
                          return InkWell(
                            onTap: (() {
                              Navigator.of(context).pushNamed(
                                  ProjectScreen.routeName,
                                  arguments: true);
                            }),
                            child: Column(
                              children: [
                                Text(
                                  listTasks.length.toString(),
                                  style: theme.textTheme.headline5!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Dự án",
                                  style: theme.textTheme.subtitle1!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded countNavBar(String name, Stream<List<dynamic>> nameCount) {
    return Expanded(
        child: Column(
      children: [
        StreamBuilder(
          stream: nameCount,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            if (snapshot.hasData) {
              final taskModal = snapshot.data!;
              return Text(
                taskModal.length.toString(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          name,
        ),
      ],
    ));
  }
}
