import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/user_login_modal.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';

import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';
import 'package:travel_app/representation/screens/form_login/login_screen.dart';
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
    final checkLogin = LocalStorageHelper.getValue('checkLogin') as bool?;
    await Future.delayed(const Duration(seconds: 1));
    if (checkLogin != null && checkLogin) {
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
    return  Scaffold(
        body: const Center(
          child: Text('CHÀO MỪNG', style: TextStyleCustom.h2TextPrimary,),
        ),
      );
  }
}
