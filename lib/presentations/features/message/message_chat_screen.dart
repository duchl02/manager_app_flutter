
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/models/message_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/presentations/features/message/cubit/message_cubit.dart';
import 'package:travel_app/presentations/features/message/widgets/message.dart';
import 'package:travel_app/services/message_services.dart';

import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';

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
  List<MessageModal> _listMessage2 = [];
  var userLogin;
  List<MessageModal> _listMessage1 = [];
  @override
  void initState() {
    userLogin = LocalStorageHelper.getValue('userLogin');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => MessageCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.userModal.name ?? "null"),
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
                                    .map(((e) => Message(
                                          messageModal: e,
                                          theme: theme,
                                          imageUser: widget.userModal.imageUser
                                              .toString(),
                                        )))
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
                                    .map(((e) => Message(
                                          messageModal: e,
                                          theme: theme,
                                          imageUser: widget.userModal.imageUser
                                              .toString(),
                                        )))
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
        bottomSheet: BlocBuilder<MessageCubit, MessageState>(
          builder: (context, state) {
            return TextField(
              focusNode: _focusNode,
              controller: textEditingController,
              enabled: true,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Tin nhắn',
                suffixIcon: InkWell(
                  onTap: () async {
                    context.read<MessageCubit>().onClickSend(
                        textEditingController,
                        _listMessage2,
                        _listMessage1,
                        widget.userModal);
                  },
                  child: Icon(
                    FontAwesomeIcons.solidPaperPlane,
                    color: Color.fromARGB(255, 0, 114, 190),
                    size: 16,
                  ),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kItemPadding),
              ),
              onSubmitted: (String submitValue) {},
            );
          },
        ),
      ),
    );
  }
}
