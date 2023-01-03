import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/representation/screens/main_app.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/form_field.dart';

import '../../../Data/models/user_login_modal.dart';
import '../../../core/helpers/local_storage_helper.dart';

class FormLoginScreen extends StatefulWidget {
  const FormLoginScreen({super.key});

  static const routeName = "/login";

  @override
  State<FormLoginScreen> createState() => _FormLoginScreenState();
}

class _FormLoginScreenState extends State<FormLoginScreen> {
  late TextEditingController userController, passwordController;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passwordController = TextEditingController();
  }

  final List<UserLoginModal> listUsers = [
    UserLoginModal(user: "admin", password: "admin"),
    UserLoginModal(user: "user", password: "user"),
  ];

  void saveUserPassword(userInput, passwordInput) async {
    final user = LocalStorageHelper.setValue('user', userInput);
    final pasword = LocalStorageHelper.setValue('password', passwordInput);
  }

  void checkLogin(userInput, passwordInput) {
    UserLoginModal userLogin =
        UserLoginModal(password: passwordInput, user: userInput);
    for (int i = 0; i < listUsers.length; i++) {
      if (listUsers[i].user == userInput &&
          listUsers[i].password == passwordInput) {
        LocalStorageHelper.setValue('checkLogin', true);
        // Navigator.pushNamed(context, MainApp.routeName);
        Navigator.pushReplacementNamed(context, MainApp.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: FormInputField(
              label: "Tên User",
              hintText: "Nhập tên user",
              controller: userController,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: FormInputField(
              label: "Mật khẩu",
              hintText: "Nhập mật khẩu",
              controller: passwordController,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: ButtonWidget(
              title: "Đăng nhập",
              ontap: () async {
                saveUserPassword(userController.text, passwordController.text);
                checkLogin(userController.text, passwordController.text);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Tài khoản admin: admin/admin"),
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text("Tài khoản user: user/user"),
          ),

          // Positioned.fill(
          //   child: ImageHelper.loadFromAsset(AssetHelper.computerGuy,
          //       fit: BoxFit.fitWidth , width: double.infinity , height: 280),
          // ),
        ],
      ),
    );
  }
}
