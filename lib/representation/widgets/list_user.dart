import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/user_model.dart';

import '../../Data/models/user_model.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/text_style.dart';
import '../../core/extensions/date_time_format.dart';
import '../screens/users_screen/user_detail_screen.dart';

class ListUser extends StatelessWidget {
  const ListUser({
    Key? key,
    this.onTapUser,
    required this.userModal,
  }) : super(key: key);

  final Function? onTapUser;
  final UserModal userModal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: (() {
        Navigator.of(context)
            .pushNamed(UserDetail.routeName, arguments: userModal);
      }),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          // color: theme.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        // child: Padding(
        // padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: NetworkImage(userModal.imageUser ??
                        "https://t4.ftcdn.net/jpg/02/29/75/83/360_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.jpg"),
                    fit: BoxFit.cover)),
          ),

          // leading: Icon(Icons.arrow_forward),
          title: Text(
            userModal.name!,
            // style: TextStyle(color: ColorPalette.text1Color),
          ),
          subtitle: Row(
            children: [
              Text("Ngày sinh: "),
              Text(userModal.birthday != null
                  ? formatDate(userModal.birthday)
                  : "null"),
              // Spacer(),
              // Text("SĐT: ", 
              // // style: TextStyleCustom.smallText
              // ),
              // Text(userModal.phoneNumber ?? "null",
              //     // style: TextStyleCustom.smallText
              //     ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
