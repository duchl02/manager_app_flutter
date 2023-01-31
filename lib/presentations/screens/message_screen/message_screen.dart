import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travel_app/Data/models/user_model.dart';

import 'package:travel_app/core/helpers/extensions/date_time_format.dart';
import 'package:travel_app/services/user_services.dart';
import '../../widgets/search_input.dart';
import 'message_chat_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  static const routeName = "/message-screen";

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tin nhắn"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SearchInput(
              controller: textEditingController,
              onChanged: (value) {
                setState(() {
                  textEditingController.text = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: StreamBuilder(
                stream: getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  if (snapshot.hasData) {
                    final userModal = snapshot.data!;
                    currentUserData = searchUser(
                        textEditingController.text, "name", userModal, []);
                    return ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: currentUserData
                          .map(((e) => listAvatarUser(
                                userModal: e,
                              )))
                          .toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  if (snapshot.hasData) {
                    final _userModal = snapshot.data!;
                    List<UserModal> _currentData = _userModal;
                    return ListView(
                      children: _currentData
                          .map(((e) => listRoom(userModal: e, theme: theme)))
                          .toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listAvatarUser({required UserModal userModal}) {
    return InkWell(
      onTap: (() {
        Navigator.of(context)
            .pushNamed(MessageChatScreen.routeName, arguments: userModal);
      }),
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                  image: NetworkImage(
                    userModal.imageUser ??
                        "https://t4.ftcdn.net/jpg/02/29/75/83/360_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.jpg",
                  ),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }

  Widget listRoom({required UserModal userModal, required ThemeData theme}) {
    return InkWell(
      onTap: (() {
        Navigator.of(context)
            .pushNamed(MessageChatScreen.routeName, arguments: userModal);
      }),
      child: Container(
        decoration: BoxDecoration(
          // color: theme.primaryColor.withOpacity(0.2) ,
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

          title: Text(
            userModal.name!,
          ),
          subtitle: Row(
            children: [
              Text("Ngày sinh: "),
              Text(userModal.birthday != null
                  ? formatDate(userModal.birthday)
                  : "null"),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
