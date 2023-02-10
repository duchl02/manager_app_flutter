import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/message_model.dart';
import 'package:travel_app/core/helpers/extensions/date_time_format.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.messageModal, required this.theme, required this.imageUser});

  final MessageModal messageModal;
  final ThemeData theme;
  final String imageUser;

  @override
  Widget build(BuildContext context) {
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
                                  image: NetworkImage(imageUser ??
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
                              ? theme.primaryColor.withOpacity(0.2)
                              : theme.disabledColor.withOpacity(0.1),
                          borderRadius: check
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                )
                              : BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
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
                // style:
              ),
            )
          ],
        ),
      ),
    );
  }
}
