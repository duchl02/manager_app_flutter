import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/models/message_modal.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/extensions/date_time_format.dart';
import 'package:travel_app/services/message_services.dart';
import 'package:travel_app/services/user_services.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismension_constants.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/helpers/local_storage_helper.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

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
  final ScrollController _listViewController = ScrollController();
  List<MessageModal> _listMessage2 = [];
  var userLogin;
  List<MessageModal> _listMessage1 = [];
  List<MessageModal> _listAllMessage = [];
  bool checkSend1 = true;
  bool checkSend2 = true;
  @override
  void initState() {
    // TODO: implement initState

    userLogin = LocalStorageHelper.getValue('userLogin');
    getToken();
    super.initState();
  }

  Future sendMessage(String text, _userSend, _userLogin) async {
    final refMessage = FirebaseFirestore.instance
        .collection("chats/$_userSend-$_userLogin/messages");
    final newMessage = MessageModal(
        createAt: DateTime.now(), sendBy: userLogin["id"], message: text);
    await refMessage.add(newMessage.toJson());
  }

  String? mtoken = " ";

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
      });
      setToken(token!);
    });
  }

  void setToken(String token) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userLogin["id"])
        .update({'token': token});
  }

  void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAreVXGPI:APA91bFAi8gc6rVmaZpDi16mrJR0I3DrS4IBDLRUWzVgLnUbrIAgWN9Bx0FvR9YqraC8wnkBIjjSzjWfIb7c7NMu4CHmoPlgdmz_MlP9xpCQomP_S7VPsSoPEWfE6pt1ijgVITCz_Q1t',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
              'android_channel_id': "dbfood"
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text(widget.userModal.name ?? "null"),
        // actions: const [Icon(FontAwesomeIcons.phone)],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder(
              stream: getAllMessages(widget.userModal.id, userLogin["id"]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.hasData) {
                  _listMessage2 = snapshot.data!;
                  if (_listMessage2.isEmpty == false) {
                    _listMessage2.sort((a, b) {
                      var adate = a.createAt;
                      var bdate = b.createAt;
                      return -adate.compareTo(bdate);
                    });

                    return Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          reverse: true,
                          children: [
                            Column(
                              children: _listMessage2.reversed
                                  .map(((e) => _messageBuilder(e)))
                                  .toList(),
                            ),
                          ]),
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            StreamBuilder(
              stream: getAllMessages(userLogin["id"], widget.userModal.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.hasData) {
                  _listMessage1 = snapshot.data!;
                  if (_listMessage1.isEmpty == false) {
                    checkSend1 = false;
                    _listMessage1.sort((a, b) {
                      var adate = a.createAt;
                      var bdate = b.createAt;
                      return -adate.compareTo(bdate);
                    });
                    return Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          reverse: true,
                          children: [
                            Column(
                              children: _listMessage1.reversed
                                  .map(((e) => _messageBuilder(e)))
                                  .toList(),
                            ),
                          ]),
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
      bottomSheet: Container(
        child: TextField(
          focusNode: _focusNode,
          controller: textEditingController,
          enabled: true,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Tin nhắn',
            suffixIcon: InkWell(
              onTap: () {
                if (_listMessage1.isEmpty && _listMessage2.isEmpty) {
                  print("1");
                  sendMessage(textEditingController.text, userLogin["id"],
                      widget.userModal.id);
                } else if (_listMessage1.isEmpty == false &&
                    _listMessage2.isEmpty) {
                  print("2");
                  sendMessage(textEditingController.text, widget.userModal.id,
                      userLogin["id"]);
                } else if (_listMessage1.isEmpty &&
                    _listMessage2.isEmpty == false) {
                  print("3");
                  sendMessage(textEditingController.text, userLogin["id"],
                      widget.userModal.id);
                }
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
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          color: check
                              ? ColorPalette.text1Color.withOpacity(0.2)
                              : ColorPalette.secondColor.withOpacity(0.1),
                          borderRadius: check
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  //  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                )
                              : BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  // bottomLeft: Radius.circular(10),
                                )),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(messageModal.message)),
                    ),
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

  // setMessage(List<MessageModal> listMessage1, List<MessageModal> listMessage2) {
  //   _listAllMessage = [];
  //   for (var e in listMessage1) {
  //     _listAllMessage.add(e);
  //   }
  //   for (var e in listMessage2) {
  //     _listAllMessage.add(e);
  //   }
  //   _listAllMessage.sort((a, b) {
  //     var adate = a.createAt;
  //     var bdate = b.createAt;
  //     return -adate.compareTo(bdate);
  //   });
  //   // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   //   setState(() {});
  //   //   // Add Your Code here.
  //   // });
  // }
}
