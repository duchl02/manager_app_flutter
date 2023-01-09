import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/representation/screens/select_range_date_screen.dart';
import 'package:travel_app/representation/widgets/form_field.dart';
import 'package:travel_app/representation/widgets/select_option.dart';

import '../../Data/models/option_modal.dart';
import '../../core/constants/color_constants.dart';
import '../../core/helpers/local_storage_helper.dart';
import '../../services/user_services.dart';
import 'package:travel_app/core/extensions/date_ext.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../widgets/button_widget.dart';

class OnLeaveScreen extends StatefulWidget {
  const OnLeaveScreen({
    super.key,
  });
  static const routeName = 'on_leave_screen';
  @override
  State<OnLeaveScreen> createState() => _OnLeaveScreenState();
}

class _OnLeaveScreenState extends State<OnLeaveScreen> {
  late TextEditingController textEditingController = TextEditingController();
  late TextEditingController dateRangeEditingController =
      TextEditingController();
  String? reasonOnLeave;
  String? userId;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Đăng ký nghỉ phép",
          ),
          backgroundColor: ColorPalette.primaryColor,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      FormInputField(
                          controller: textEditingController,
                          label: "Lý do",
                          hintText: "Nhập lý do ghỉ phép"),
                      SelectOption(
                          label: "Loại lý do",
                          list: _list,
                          dropdownValue: reasonOnLeave ?? "",
                          onChanged: ((p0) {
                            reasonOnLeave = p0 as String;
                          })),
                      StreamBuilder(
                        stream: getAllUsers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          if (snapshot.hasData) {
                            final userModal = snapshot.data!;
                            List<OptionModal> _listSatff = [];

                            for (var e in userModal) {
                              _listSatff.add(
                                  OptionModal(value: e.id!, display: e.name!));
                            }
                            return SelectOption(
                              label: "Người duyệt (Quản lý của bạn)",
                              list: _listSatff,
                              dropdownValue: userId ?? "",
                              onChanged: (p0) {
                                userId = p0 as String;
                              },
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      FormInputField(
                          controller: dateRangeEditingController,
                          label: "Thời gian",
                          hintText: "Chọn thời gian nghỉ phép",
                          onTap: () async {
                            final result = await Navigator.of(context)
                                .pushNamed(SelectRangeDateScreen.routeName);
                            if (result is List<DateTime?>) {
                              setState(() {
                                dateRangeEditingController.text =
                                    'Từ ${result[0]?.getStartDate} đến ${result[1]?.getEndDate}';
                              });
                            }
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: ButtonWidget(
                                  color:
                                      ColorPalette.secondColor.withOpacity(0.2),
                                  title: "Hủy",
                                  ontap: (() {
                                    Navigator.of(context).pop();
                                  }),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: StreamBuilder(
                                stream: getAllUsers(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  if (snapshot.hasData) {
                                    final userModal = snapshot.data!;
                                    var userLogin = LocalStorageHelper.getValue(
                                        'userLogin');
                                    UserModal _user = UserModal();
                                    for (var e in userModal) {
                                      if (e.id == userLogin["id"]) {
                                        _user = e;
                                      }
                                    }
                                    String _emailToCc = "";

                                    for (var e in userModal) {
                                      if (e.id == userId) {
                                        _emailToCc = e.email!;
                                      }
                                    }
                                    String _toEmail = _user.email!;
                                    "vanducbaymatdep@gmail.com";
                                    String htmlContent =
                                        "<h1>Xin chào ${_user.name} </h1>\n<p>Hệ thống đã xác nhận bạn xin nghỉ phép ${dateRangeEditingController.text}.</p> \n <p> Lý do nghỉ: ${textEditingController.text} <p/> \n  <p> Loại lý do: ${reasonOnLeave} <p/> ";
                                    return ButtonWidget(
                                      title: "Xác nhận",
                                      ontap: () async {
                                        submitBtn(
                                            _toEmail, _emailToCc, htmlContent);
                                      },
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }

  void submitBtn(
    toEmail,
    emailToCc,
    htmlContent,
  ) async {
    String username = 'vanducbaymatdep@gmail.com';
    String password = 'ealkufrsjcnemekp';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Hệ thống xác nhận')
      ..recipients.add(toEmail)
      ..ccRecipients.addAll([emailToCc])
      ..bccRecipients.add(Address(emailToCc))
      ..subject = 'Thư xác nhận nghỉ phép'
      ..html = htmlContent;

    try {
      setState(() {
        isLoading = true;
      });
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        Navigator.of(context).pop();
      }

      await EasyLoading.showSuccess(
          "Hệ thống đã xác nhận. Xin hãy kiểm tra email của bạn");
    } on MailerException catch (e) {
      print(e);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      setState(() {
        isLoading = false;
      });
      await EasyLoading.showError("Hệ thống đã xảy ra lỗi. Xin hãy thử lại");
    }
  }
}

List<OptionModal> _list = [
  OptionModal(value: "Nghỉ có lương", display: "Nghỉ có lương"),
  OptionModal(value: "Nghỉ không lương", display: "Nghỉ không lương"),
  OptionModal(value: "Nghỉ buổi sáng", display: "Nghỉ buổi sáng"),
  OptionModal(value: "Nghỉ buổi chiều", display: "Nghỉ buổi chiều"),
  OptionModal(value: "Nghỉ ốm có giấy", display: "Nghỉ ốm có giấy"),
  OptionModal(value: "Nghỉ nghỉ sinh con", display: "Nghỉ nghỉ sinh con"),
  OptionModal(value: "Nghỉ phép năm", display: "Nghỉ phép năm"),
];
