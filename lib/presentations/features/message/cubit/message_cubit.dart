import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_app/Data/models/message_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';

part 'message_state.dart';
part 'message_cubit.freezed.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageState.initial());

  Future<void> onClickSend(
      TextEditingController textEditingController,
      List<MessageModal> listMessage2,
      List<MessageModal> listMessage1,
      UserModal userModal) async {
    sendPushMessage(
        textEditingController.text, userLogin["name"], userModal.token!);
    if (listMessage1.isEmpty && listMessage2.isEmpty) {
      sendMessage(textEditingController.text, userLogin["id"], userModal.id);
    } else if (listMessage1.isEmpty == false && listMessage2.isEmpty) {
      sendMessage(textEditingController.text, userModal.id, userLogin["id"]);
    } else if (listMessage1.isEmpty && listMessage2.isEmpty == false) {
      sendMessage(textEditingController.text, userLogin["id"], userModal.id);
    }
    textEditingController.clear();
  }

  var userLogin = LocalStorageHelper.getValue('userLogin');

  Future sendMessage(String text, userSend, userLogin) async {
    final refMessage = FirebaseFirestore.instance
        .collection("chats/$userSend-$userLogin/messages");
    final newMessage = MessageModal(
        createAt: DateTime.now(), sendBy: userSend, message: text);
    await refMessage.add(newMessage.toJson());
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
}
