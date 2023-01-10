import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/models/message_modal.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/extensions/date_time_format.dart';
import 'package:travel_app/services/message_services.dart';
import 'package:travel_app/services/user_services.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismension_constants.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/helpers/local_storage_helper.dart';

class MessageChatScreen extends StatefulWidget {
  const MessageChatScreen({super.key, required this.userModal});

  static const routeName = "/message-chat-screen";
  final UserModal userModal;

  @override
  State<MessageChatScreen> createState() => _MessageChatScreenState();
}

class _MessageChatScreenState extends State<MessageChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  final _focusNode = FocusNode();
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var userLogin = LocalStorageHelper.getValue('userLogin');

    List<MessageModal> _listMessages = [
      MessageModal(
          createAt: DateTime.now(),
          sendBy: widget.userModal.id!,
          message: "hello world"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text(widget.userModal.name ?? "null"),
        // actions: const [Icon(FontAwesomeIcons.phone)],
      ),
      body: SingleChildScrollView(
        primary: false,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  SizedBox(
                    child: StreamBuilder(
                      stream:
                          getAllMessages(userLogin["id"], widget.userModal.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.hasData) {
                          final _listUser = snapshot.data!;

                          return ListView(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              children: [
                                Column(
                                  children: _listUser
                                      .map(((e) => _messageBuilder(e)))
                                      .toList(),
                                ),
                              ]);
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    // child: ListView(
                    //     shrinkWrap: true,
                    //     physics: ClampingScrollPhysics(),
                    //     children: [
                    //       Column(
                    //         children: _listMessages
                    //             .map(((e) => _messageBuilder(e)))
                    //             .toList(),
                    //       ),
                    //     ]),
                  ),
                ],
              ),
            ]),
      ),
      bottomNavigationBar: Container(
        child: TextField(
          focusNode: _focusNode,
          controller: textEditingController,
          enabled: true,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Tin nhắn',
            suffixIcon: InkWell(
              onTap: () {
                textEditingController.text.isEmpty
                    ? null
                    : MessageServices.sendMessage(textEditingController.text,
                        userLogin["id"], widget.userModal.id);
                textEditingController.clear();
              },
              child: Icon(
                FontAwesomeIcons.solidPaperPlane,
                color: Color.fromARGB(255, 0, 114, 190),
                size: 16,
              ),
            ),
            filled: true,
            fillColor: ColorPalette.subTitleColor.withOpacity(0.2),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: kItemPadding),
          ),
          style: TextStyleCustom.normalSizeBlack,
          // onChanged: widget.onChanged,
          onSubmitted: (String submitValue) {},
        ),
      ),
    );
  }

  Widget _messageBuilder(MessageModal messageModal) {
    bool check = false;
    var userLogin = LocalStorageHelper.getValue('userLogin');

    if (messageModal.sendBy == userLogin["id"]) {
      check = true;
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              check ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment:
                    check ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  check
                      ? SizedBox()
                      : Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: NetworkImage(widget
                                          .userModal.imageUser ??
                                      "https://t4.ftcdn.net/jpg/02/29/75/83/360_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: check
                            ? ColorPalette.text1Color.withOpacity(0.2)
                            : ColorPalette.secondColor.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(messageModal.message)),
                  )
                ],
              ),
            ),
            Container(
              margin:
                  check ? EdgeInsets.only(left: 6) : EdgeInsets.only(left: 46),
              child: Text(
                formatDateAndTime(messageModal.createAt),
                style:
                    TextStyle(color: ColorPalette.secondColor.withOpacity(0.7)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
