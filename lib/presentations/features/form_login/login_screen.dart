import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/presentations/features/form_login/cubit/login_cubit.dart';
import 'package:travel_app/presentations/widgets/button_widget.dart';
import 'package:travel_app/presentations/widgets/form_field.dart';

import 'package:travel_app/services/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormLoginScreen extends StatefulWidget {
  const FormLoginScreen({super.key});

  static const routeName = "/login";

  @override
  State<FormLoginScreen> createState() => _FormLoginScreenState();
}

class _FormLoginScreenState extends State<FormLoginScreen> {
  late TextEditingController userController, passwordController;
  late List<UserModal> listUser;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
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
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding),
                      child: ButtonWidget(
                        isCancel: false,
                        title: "Đăng nhập",
                        ontap: () {
                          context.read<LoginCubit>().onClickLogin(listUser, userController.text, passwordController.text, context);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
