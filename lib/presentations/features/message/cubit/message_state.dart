part of 'message_cubit.dart';

enum SendStatus { success, loading, fail }

@freezed
class MessageState with _$MessageState {
  MessageState._();
  factory MessageState({required SendStatus status}) = _MessageState;
  factory MessageState.initial() {
    var userLogin = LocalStorageHelper.getValue('userLogin');
    String? mtoken = " ";
    void setToken(String token) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userLogin["id"])
          .update({'token': token});
    }

    void getToken() async {
      await FirebaseMessaging.instance.getToken().then((token) {
        mtoken = token;
        setToken(token!);
      });
    }

    getToken();

    return MessageState(status: SendStatus.success);
  }
  bool get isLoading => status == SendStatus.loading;
}
