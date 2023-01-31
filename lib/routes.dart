import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/project_model.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/presentations/screens/form_login/login_screen.dart';
import 'package:travel_app/presentations/screens/home_screen/home_screen.dart';
import 'package:travel_app/presentations/screens/main_app.dart';
import 'package:travel_app/presentations/screens/message_screen/message_chat_screen.dart';
import 'package:travel_app/presentations/screens/message_screen/message_screen.dart';
import 'package:travel_app/presentations/screens/on_leave_screen.dart';
import 'package:travel_app/presentations/screens/priview_image_screen.dart';
import 'package:travel_app/presentations/screens/project_screen/project_detail.dart';
import 'package:travel_app/presentations/screens/project_screen/project_screen.dart';
import 'package:travel_app/presentations/screens/select_date_screen.dart';
import 'package:travel_app/presentations/screens/select_range_date_screen.dart';
import 'package:travel_app/presentations/screens/users_screen/user_detail_screen.dart';
import 'package:travel_app/presentations/screens/users_screen/users_screen.dart';
import 'package:travel_app/presentations/screens/task_screen/task_detail_screen.dart';
import 'package:travel_app/presentations/screens/task_screen/task_screen.dart';

final Map<String, WidgetBuilder> routes = {};

PageRoute? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case UserScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => UserScreen(), settings: settings);
    case MessageScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => MessageScreen(), settings: settings);
    case ProjectScreen.routeName:
      late final bool checkUser = (settings.arguments as bool);

      return CupertinoPageRoute(
          builder: (context) => ProjectScreen(
                checkIsUser: checkUser,
              ),
          settings: settings);
    case TaskScreen.routeName:
      late final bool checkUser = (settings.arguments as bool);

      return CupertinoPageRoute(
          builder: (context) => TaskScreen(
                checkIsUser: checkUser,
              ),
          settings: settings);
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
    case MessageChatScreen.routeName:
      late final UserModal userModal = (settings.arguments as UserModal);
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => MessageChatScreen(
          userModal: userModal,
        ),
      );
    case SelectDateScreen.routeName:
      late final List<DateTime> listDates =
          (settings.arguments as List<DateTime>);
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => SelectDateScreen(
          initialDates: listDates,
        ),
      );

    case MainApp.routeName:
      return CupertinoPageRoute(
          builder: (context) => MainApp(), settings: settings);
    case FormLoginScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => FormLoginScreen(), settings: settings);
    case OnLeaveScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => OnLeaveScreen(), settings: settings);
    case SelectRangeDateScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => SelectRangeDateScreen(), settings: settings);
    case PreviewImageScreen.routeName:
      late final String urlImage = (settings.arguments as String);
      return MaterialPageRoute(
          builder: (context) => PreviewImageScreen(
                img: urlImage,
              ),
          settings: settings);
    default:
      return null;
  }
}

class RoomModel {}
