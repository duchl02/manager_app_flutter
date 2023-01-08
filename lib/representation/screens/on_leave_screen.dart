import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/representation/screens/select_range_date_screen.dart';
import 'package:travel_app/representation/widgets/form_field.dart';
import 'package:travel_app/representation/widgets/select_option.dart';

import '../../Data/models/option_modal.dart';
import '../../core/constants/color_constants.dart';
import '../../services/user_services.dart';
import 'package:travel_app/core/extensions/date_ext.dart';

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
  late String reasonOnLeave;
  late String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "dang ky nghi phep",
        ),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: Padding(
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
                dropdownValue: _list[0].value,
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
                    _listSatff.add(OptionModal(value: e.id!, display: e.name!));
                  }
                  return SelectOption(
                    label: "Người duyệt (Quản lý của bạn)",
                    list: _listSatff,
                    dropdownValue: _listSatff[0].value ?? "",
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
                      child: ButtonWidget(
                        title: "Xác nhận",
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<OptionModal> _list = [
  OptionModal(value: "T1", display: "Nghỉ có lương"),
  OptionModal(value: "T2", display: "Nghỉ không lương"),
  OptionModal(value: "T3", display: "Nghỉ buổi sáng"),
  OptionModal(value: "T4", display: "Nghỉ buổi chiều"),
  OptionModal(value: "T5", display: "Nghỉ ốm có giấy"),
  OptionModal(value: "T6", display: "Nghỉ nghỉ sinh con"),
  OptionModal(value: "T7", display: "Nghỉ phép năm"),
];
