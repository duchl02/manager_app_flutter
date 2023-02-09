import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_app/Data/models/user_login_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';
import 'package:travel_app/presentations/features/root/root_page.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());
  Future<void> onClickLogin(List<UserModal> list, String username,
      String password, BuildContext context) async {
    bool checkLogin = false;

    list.forEach((element) async {
      if (element.userName == username && element.password == password) {
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
        getToken();
        LoginState(status: LoginStatus.login);
        return;
      }
    });
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

  void checkLogin(userInput, passwordInput) async {}
}
