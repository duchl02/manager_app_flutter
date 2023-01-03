import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/representation/screens/form_login/login_screen.dart';
import 'package:travel_app/representation/screens/home_screen/home_screen.dart';
import 'package:travel_app/representation/screens/project_screen/project_screen.dart';
import 'package:travel_app/representation/widgets/selectMultiCustom.dart';
import 'package:travel_app/representation/screens/users_screen/users_screen.dart';
import 'package:travel_app/representation/screens/task_screen/task_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  static const routeName = "/main_app";
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  final _pageCotroller = PageController();
  final _pages = [
    UserScreen(),
    
    ProjectScreen(),

    HomeScreen(),

    TaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageCotroller,
      ),
      bottomNavigationBar: usingBottomNavigator(),
    );
  }

  SalomonBottomBar usingBottomNavigator() {
    return SalomonBottomBar(
        currentIndex: _currentIndex,
        
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageCotroller.animateToPage(_currentIndex,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          });
        },
        selectedItemColor: ColorPalette.primaryColor,
        unselectedItemColor: ColorPalette.primaryColor.withOpacity(0.4),
        margin: EdgeInsets.symmetric(
            horizontal: kMediumPadding, vertical: kDefaultPadding),
        items: [
          SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.house,
                size: kDefaultIconSize,
              ),
              title: Text("Trang chủ")),
          SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.list,
                size: kDefaultIconSize,
              ),
              title: Text("Task")),
          SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.briefcase,
                size: kDefaultIconSize,
              ),
              title: Text("Dự án")),
          SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.solidUser,
                size: kDefaultIconSize,
              ),
              title: Text("Nhân viên"))
        ]);
  }
}
