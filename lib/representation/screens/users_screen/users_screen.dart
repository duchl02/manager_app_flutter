import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/representation/screens/users_screen/user_detail_screen.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/search_input.dart';
import 'package:travel_app/representation/widgets/select_option.dart';
import 'package:travel_app/services/user_services.dart';

import '../../../Data/models/option_modal.dart';
import '../../../Data/models/user_model.dart';
import '../../../services/user_services.dart';
import '../../widgets/list_user.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({
    super.key,
  });

  static const routeName = '/user_screen';

  @override
  State<UserScreen> createState() => _UserScreenState();
  // final UserModal userModal;
}

class _UserScreenState extends State<UserScreen> {
  // String dropdownValue = list.first

  @override
  void initState() {
    super.initState();
    category = _list[0].value;
    isSearch = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isSearch = false;
  }

  final UserModal userModalEmty = UserModal();
  List<UserModal> list = [];
  bool isSearch = false;
  late String category;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            if (snapshot.hasData) {
              final userModal = snapshot.data!;
              userModal.map(
                (e) {},
              );
              return Text(
                "Nhân viên (" + userModal.length.toString() + ")",
                // style: TextStyleCustom.h1Text,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        backgroundColor: ColorPalette.primaryColor,
        actions: [
          InkWell(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  FontAwesomeIcons.plus,
                )),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(UserDetail.routeName, arguments: userModalEmty);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(children: [
          SearchInput(
            controller: textEditingController,
            onChanged: (value) {
              setState(() {
                textEditingController.text = value;
              });
            },
          ),
          SizedBox(
            height: 5,
          ),
          Row(children: [
            Expanded(
              flex: 3,
              child: SelectOption(
                searchOption: 0,
                list: _list,
                dropdownValue: category,
                onChanged: ((p0) {
                  category = p0.toString();
                }),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 2,
                child: ButtonWidget(
                  title: "Tìm kiếm",
                  ontap: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                ))
          ]),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: StreamBuilder(
            stream: getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              if (snapshot.hasData) {
                final userModal = snapshot.data!;
                // currentUserData = searchUser(
                //     textEditingController.text, category, userModal);
                // if (isSearch == false) {
                return ListView(
                  children: userModal
                      .map(((e) => ListUser(
                            userModal: e,
                          )))
                      .toList(),
                );
                // } else {
                //   return ListView(
                //     children: currentUserData
                //         .map(((e) => ListUser(
                //               userModal: e,
                //             )))
                //         .toList(),
                //   );
                // }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ))
        ]),
      ),
    );
  }
}

List<OptionModal> _list = [
  OptionModal(value: "name", display: "Tên"),
  OptionModal(value: "userName", display: "Tên user"),
  OptionModal(value: "phoneNumber", display: "Số điện thoại"),
  OptionModal(value: "project", display: "Tên project"),
];
