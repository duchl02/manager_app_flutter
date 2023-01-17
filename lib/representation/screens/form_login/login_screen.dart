import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/representation/screens/main_app.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/form_field.dart';

import '../../../Data/models/user_login_modal.dart';
import '../../../core/helpers/local_storage_helper.dart';
import '../../../services/user_services.dart';

class FormLoginScreen extends StatefulWidget {
  const FormLoginScreen({super.key});

  static const routeName = "/login";

  @override
  State<FormLoginScreen> createState() => _FormLoginScreenState();
}

class _FormLoginScreenState extends State<FormLoginScreen> {
  late TextEditingController userController, passwordController;
  List<UserModal>? listUser;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    getToken();
    super.dispose();
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setToken(token!);
    });
  }

  var userLogin = LocalStorageHelper.getValue('userLogin');
  void setToken(String token) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userLogin["id"])
        .update({'token': token});
  }


  void checkLogin(userInput, passwordInput) async {
    bool checkLogin = false;
    listUser?.forEach((element) async {
      if (element.userName == userInput && element.password == passwordInput) {
        checkLogin = true;
        UserLoginModal userLoginModal = UserLoginModal(
            password: element.password!,
            name: element.name!,
            token: element.token!,
            user: element.userName!,
            id: element.id!,
            position: element.position!);
        LocalStorageHelper.setValue('checkLogin', true);
        LocalStorageHelper.setValue('userLogin', userLoginModal.toJson());
        Navigator.pushReplacementNamed(context, MainApp.routeName);
        await EasyLoading.showSuccess("Đăng nhập thành công");
        return;
      }
    });
    print(LocalStorageHelper.getValue('userLogin'));
    if (checkLogin == false) {
      await confirm(
        context,
        title: const Text('Lỗi đăng nhập'),
        content: Text('Mật khẩu hoặc tên đăng nhập không đúng'),
        textOK: const Text('Xác nhận'),
        textCancel: const Text('Thoát'),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(

            children: <Widget>[
              StreamBuilder(
                stream: getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  if (snapshot.hasData) {
                    final userModal = snapshot.data!;
                    listUser = userModal;
                    return Text('');
                  } else {
                    return Text('');
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40, top: 80),
                child: Column(children: [
                  ImageHelper.loadFromAsset(AssetHelper.flutterLogo,
                      width: MediaQuery.of(context).size.width * 0.5),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Chào mừng quay trở lại!",
                      style: theme.textTheme.headline6,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Đăng nhập để bắt đầu",
                      style: theme.textTheme.headline6,
                    ),
                  )
                ]),
              ),
              FormInputField(
                label: "Tên User",
                hintText: "Nhập tên user",
                controller: userController,
              ),
              FormInputField(
                obscureText: true,
                label: "Mật khẩu",
                hintText: "Nhập mật khẩu",
                controller: passwordController,
              ),
              Padding(
                padding: EdgeInsets.only(top: kDefaultPadding),
                child: ButtonWidget(
                  isCancel: false,
                  title: "Đăng nhập",
                  ontap: () async {
                    checkLogin(userController.text, passwordController.text);
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
