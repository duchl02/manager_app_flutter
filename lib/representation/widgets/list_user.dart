import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/user_model.dart';

import '../../Data/models/user_model.dart';
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
    return InkWell(
      onTap: (() {
        Navigator.of(context)
            .pushNamed(UserDetail.routeName, arguments: userModal);
      }),
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(userModal.name!, style: TextStyleCustom.nomalTextPrimary),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text("Ngày sinh: "),
                Text(userModal.birthday != null
                    ? formatDate(userModal.birthday)
                    : "null"),
                Spacer(),
                Text("SĐT ", style: TextStyleCustom.smallText),
                Text(userModal.phoneNumber ?? "null",
                    style: TextStyleCustom.smallText),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text("Địa chỉ: ", style: TextStyleCustom.smallText),
                Text(userModal.address ?? "null" , style: TextStyleCustom.smallText),

                Spacer(),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
