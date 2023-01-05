import 'package:flutter/cupertino.dart';
import 'package:travel_app/Data/models/project_model.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/representation/screens/form_login/login_screen.dart';
import 'package:travel_app/representation/screens/home_screen/home_screen.dart';
import 'package:travel_app/representation/screens/intro_screen.dart';
import 'package:travel_app/representation/screens/main_app.dart';
import 'package:travel_app/representation/screens/project_screen/project_detail.dart';
import 'package:travel_app/representation/screens/project_screen/project_screen.dart';
import 'package:travel_app/representation/screens/select_date_screen.dart';
import 'package:travel_app/representation/screens/users_screen/user_detail_screen.dart';
import 'package:travel_app/representation/screens/users_screen/users_screen.dart';
import 'package:travel_app/representation/screens/task_screen/task_detail_screen.dart';
import 'package:travel_app/representation/screens/task_screen/task_screen.dart';

final Map<String, WidgetBuilder> routes = {};

PageRoute? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case UserScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => UserScreen(), settings: settings);
    case ProjectScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => ProjectScreen(), settings: settings);
    case TaskScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => TaskScreen(), settings: settings);
    case HomeScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => HomeScreen(), settings: settings);

    case TaskDetail.routeName:
      late final TaskModal taskModal = (settings.arguments as TaskModal);
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => TaskDetail(
          taskModal: taskModal,
        ),
      );
    case ProjectDetail.routeName:
      late final ProjectModal projectModal =
          (settings.arguments as ProjectModal);
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => ProjectDetail(
          projectModal: projectModal,
        ),
      );
    case UserDetail.routeName:
      late final UserModal userModal = (settings.arguments as UserModal);
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => UserDetail(
          userModal: userModal,
        ),
      );
    case SelectDateScreen.routeName:
      late final List<DateTime> listDates = (settings.arguments as List<DateTime>);
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => SelectDateScreen(
          initialDates: listDates,
        ),
      );

    case MainApp.routeName:
      return CupertinoPageRoute(
          builder: (context) => MainApp(), settings: settings);
    case IntroScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => IntroScreen(), settings: settings);

    // case SelectDateScreen.routeName:
    //   return CupertinoPageRoute(
    //       builder: (context) => SelectDateScreen(), settings: settings);

    case FormLoginScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => FormLoginScreen(), settings: settings);
    default:
      return null;
  }
}

class RoomModel {}
