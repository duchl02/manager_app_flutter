import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/user_login_modal.dart';

import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';
import 'package:travel_app/representation/screens/form_login/login_screen.dart';
import 'package:travel_app/representation/screens/intro_screen.dart';
import 'package:travel_app/representation/screens/main_app.dart';

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
    
    final checkLogin =
        LocalStorageHelper.getValue('checkLogin') as bool?;
    await Future.delayed(const Duration(seconds: 2));
    if (checkLogin != null && checkLogin) {
      Navigator.of(context).pushNamed(MainApp.routeName);
    } else {
      LocalStorageHelper.setValue("ignoreIntroScreen", true);
      Navigator.of(context).pushNamed(FormLoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: ImageHelper.loadFromAsset(AssetHelper.backgroundSplash,
            fit: BoxFit.fitWidth),
      ),
      Positioned.fill(
        child: ImageHelper.loadFromAsset(AssetHelper.circleSplash,
            fit: BoxFit.fitWidth),
      )
    ]);
  }
}
