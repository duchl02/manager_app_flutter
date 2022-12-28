import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/project_model.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/representation/screens/Guest_and_room_booking_screen.dart';
import 'package:travel_app/representation/screens/check_out_screen.dart';
import 'package:travel_app/representation/screens/form_login/login_screen.dart';
import 'package:travel_app/representation/screens/home_booking_screen.dart';
import 'package:travel_app/representation/screens/home_screen/home_screen.dart';
import 'package:travel_app/representation/screens/hotel_detail_screen.dart';
import 'package:travel_app/representation/screens/hotel_screen.dart';
import 'package:travel_app/representation/screens/intro_screen.dart';
import 'package:travel_app/representation/screens/main_app.dart';
import 'package:travel_app/representation/screens/project_screen/project_detail.dart';
import 'package:travel_app/representation/screens/project_screen/project_screen.dart';
import 'package:travel_app/representation/screens/room_screen.dart';
import 'package:travel_app/representation/screens/select_date_screen.dart';
import 'package:travel_app/representation/screens/splash_screen.dart';
import 'package:travel_app/representation/screens/staffs_screen/staffs_screen.dart';
import 'package:travel_app/representation/screens/task_screen/task_detail_screen.dart';
import 'package:travel_app/representation/screens/task_screen/task_screen.dart';

import 'Data/models/hotel_modal.dart';

final Map<String, WidgetBuilder> routes = {};

PageRoute? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case StaffsScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => StaffsScreen(), settings: settings);
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
      late final ProjectModal projectModal = (settings.arguments as ProjectModal);
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => ProjectDetail(
          projectModal: projectModal,
        ),
      );

    case HotelScreenDetail.routeName:
      late final HotelModel hotelModel = (settings.arguments as HotelModel);
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => HotelScreenDetail(
          hotelModel: hotelModel,
        ),
      );
    case CheckOutScreen.routeName:
      final RoomModel roomModel = (settings.arguments as RoomModel);
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => CheckOutScreen(
          roomModel: roomModel,
        ),
      );
    case MainApp.routeName:
      return CupertinoPageRoute(
          builder: (context) => MainApp(), settings: settings);
    case IntroScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => IntroScreen(), settings: settings);
    case HotelScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => HotelScreen(), settings: settings);
    case HomeBookingScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => HomeBookingScreen(), settings: settings);
    case SelectDateScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => SelectDateScreen(), settings: settings);
    case GuestAndRoomBookingScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => GuestAndRoomBookingScreen(),
          settings: settings);
    case RoomScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => RoomScreen(), settings: settings);
    case FormLoginScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => FormLoginScreen(), settings: settings);
    case StaffsScreen.routeName:
      return CupertinoPageRoute(
          builder: (context) => StaffsScreen(), settings: settings);
    default:
      return null;
  }
}

class RoomModel {}
