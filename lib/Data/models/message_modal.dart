import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModal {
  MessageModal({
    required this.createAt,
    required this.sendBy,
    required this.message,

  });

  final DateTime createAt;
  final String sendBy;
  final String message;

  static MessageModal fromJson(Map<String, dynamic> json) => MessageModal(
        sendBy: json["sendBy"],
        message: json['message'],
        createAt: (json['createAt'] as Timestamp).toDate(),
      );

        Map<String, dynamic> toJson() => {
        "sendBy": sendBy,
        "message": message,
        "createAt": createAt,
      };
}