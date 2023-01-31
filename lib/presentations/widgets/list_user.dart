
import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/user_model.dart';

import '../../core/helpers/extensions/date_time_format.dart';
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
          borderRadius: BorderRadius.circular(10),
        ),
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
          title: Text(
            userModal.name!,
          ),
          subtitle: Row(
            children: [
              Text("Ngày sinh: "),
              Text(userModal.birthday != null
                  ? formatDate(userModal.birthday)
                  : "null"),

            ],
          ),
        ),
      ),
      // ),
    );
  }
}
