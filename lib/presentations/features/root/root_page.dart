import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/presentations/features/root/tabs/home_screen.dart';
import 'package:travel_app/presentations/features/root/tabs/message_screen.dart';
import 'package:travel_app/presentations/features/root/tabs/project_screen.dart';
import 'package:travel_app/presentations/features/root/tabs/users_screen.dart';
import 'package:travel_app/presentations/features/root/tabs/task_screen.dart';

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
    HomeScreen(),
    MessageScreen(),
    TaskScreen(),
    ProjectScreen(),
    UserScreen(),
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

  SingleChildScrollView usingBottomNavigator() {
    return SingleChildScrollView(
      child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageCotroller.animateToPage(_currentIndex,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            });
          },
          margin: EdgeInsets.symmetric(
              horizontal: kMediumPadding, vertical: kDefaultPadding),
          items: [
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.house,
                  size: kDefaultIconSize,
                ),
                title: Text("")),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.solidMessage,
                  size: kDefaultIconSize,
                ),
                title: Text("")),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.list,
                  size: kDefaultIconSize,
                ),
                title: Text("")),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.briefcase,
                  size: kDefaultIconSize,
                ),
                title: Text("")),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.solidUser,
                  size: kDefaultIconSize,
                ),
                title: Text("")),
          ]),
    );
  }
}
