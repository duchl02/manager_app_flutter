import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';
import 'package:travel_app/presentations/features/form_login/login_screen.dart';

import 'package:travel_app/presentations/features/root/root_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = "/splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirectIntoScreen();
  }

  void redirectIntoScreen() async {
    final checkLogin = LocalStorageHelper.getValue('checkLogin') as bool?;
    await Future.delayed(const Duration(seconds: 1));
    if (checkLogin != null && checkLogin == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, MainApp.routeName);
    } else {
      LocalStorageHelper.setValue("ignoreIntroScreen", true);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, FormLoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          'CHÀO MỪNG',
          style: theme.textTheme.headline4,
        ),
      ),
    );
  }
}
