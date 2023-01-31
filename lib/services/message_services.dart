import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/Data/models/message_model.dart';

class MessageServices {
  static Future sendMessage(String text, userSend, userLogin) async {
  print('---------------------------------------');

    final refMessage = FirebaseFirestore.instance
        .collection("chats/$userLogin-$userSend/messages");
    final newMessage = MessageModal(
        createAt: DateTime.now(), sendBy: userLogin, message: text);
    await refMessage.add(newMessage.toJson());
  }
}

Stream<List<MessageModal>> getAllMessages(userSend, userLogin) {
  var data = FirebaseFirestore.instance
      .collection("chats/$userLogin-$userSend/messages")
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => MessageModal.fromJson(doc.data()))
          .toList());
  return data;
}
