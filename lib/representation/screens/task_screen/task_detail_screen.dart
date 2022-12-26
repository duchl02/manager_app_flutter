import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/form_field.dart';
import 'package:travel_app/representation/widgets/select_option.dart';

import '../../../core/constants/color_constants.dart';
import '../../widgets/custom-select.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key, required this.taskModal});

  static const String routeName = "/task_detail";

  final TaskModal taskModal;

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? timeSuccessController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  late String userId = _listSatff[0];
  late String projectId = _listProject[0];
  late String priorityId = _listPriority[0];
  late String statusId = _listStatus[0];
  @override
  void initState() {
    super.initState();
    setValue();
    // userController = TextEditingController();
    // passwordController = TextEditingController();
  }

  void setValue() {
    if (widget.taskModal.name != null) {
      nameController!.text = widget.taskModal.name!;
    }
    if (widget.taskModal.timeSuccess != null) {
      timeSuccessController!.text = widget.taskModal.timeSuccess!;
    }
    if (widget.taskModal.description != null) {
      descriptionController!.text = widget.taskModal.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text("Edit Task"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Ngày tạo: "),
                  Text(widget.taskModal.createAt != null
                      ? widget.taskModal.createAt!.toIso8601String()
                      : "Chưa có")
                ],
              ),
              Row(
                children: [
                  Text("Ngày chỉnh sửa: "),
                  Text(widget.taskModal.updateAt != null
                      ? widget.taskModal.updateAt!.toIso8601String()
                      : "Chưa có")
                ],
              ),
              FormInputField(
                label: "Tiêu đề",
                hintText: "Nhập tiêu đề",
                controller: nameController,
                onChanged: (value) {
                  nameController!.text = value;
                },
              ),
              // FormInputField(label: "Người thực hiện", hintText: "Nhập tiêu đề"),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 2),
                child: Text(
                  "Người thực hiện",
                  style:
                      TextStyle(color: ColorPalette.primaryColor, fontSize: 18),
                ),
              ),
              SelectOption(
                list: _listSatff,
                dropdownValue: _listSatff[0],
                onChanged: (p0) {
                  userId = p0 as String;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 2),
                child: Text(
                  "Dự án",
                  style:
                      TextStyle(color: ColorPalette.primaryColor, fontSize: 18),
                ),
              ),
              SelectOption(
                list: _listProject,
                dropdownValue: _listProject[0],
                onChanged: (p0) {
                  projectId = p0 as String;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 2),
                child: Text(
                  "Độ ưu tiên",
                  style:
                      TextStyle(color: ColorPalette.primaryColor, fontSize: 18),
                ),
              ),
              SelectOption(
                list: _listPriority,
                dropdownValue: _listPriority[0],
                onChanged: (p0) {
                  priorityId = p0 as String;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 2),
                child: Text(
                  "Trạng thái",
                  style:
                      TextStyle(color: ColorPalette.primaryColor, fontSize: 18),
                ),
              ),
              SelectOption(
                list: _listStatus,
                dropdownValue: _listStatus[0],
                onChanged: (p0) {
                  statusId = p0 as String;
                },
              ),
              FormInputField(
                label: "Thời gian hoàn thành",
                hintText: "Nhập số giờ",
              ),
              FormInputField(
                label: "Mô tả",
                hintText: "Nhập mô tả",
                maxLines: 3,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: ButtonWidget(
                          color: Color.fromARGB(255, 255, 8, 0),
                          title: "Hủy",
                          ontap: (() {
                            Navigator.of(context).pop();
                          }),
                        )),
                    SizedBox(
                      width: kDefaultPadding,
                    ),
                    Flexible(
                        flex: 1,
                        child: ButtonWidget(
                          title: "Xác nhận",
                          ontap: () async {
                            // if (await confirm(
                            //   context,
                            //   title: const Text('Chỉnh sửa Task'),
                            //   content: const Text('Bạn chắc chắn muốn sửa'),
                            //   textOK: const Text('Có'),
                            //   textCancel: const Text('Không'),
                            // )) {
                            await EasyLoading.showSuccess("Thành công");
                            Navigator.of(context).pop();
                            //   Navigator.of(context).pop();
                            //   // return null;
                            // }
                            // return null;
                          },
                        )),
                  ],
                ),
              ) // FormInputField(label: "Thời gian bắt đầu", hintText: "Nhập tiêu đề"),
              // FormInputField(label: "Thời gian kết thúc", hintText: "Nhập tiêu đề"),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> _listSatff = <String>[
  'Nguyễn Văn Đức',
  'Trần Ngọc Quý',
  'Trần Ngọc Hà',
  'Nguyễn Nhân Hiệu'
];

const List<String> _listProject = <String>[
  'Học Flutter',
  'Học OOP',
  'App quản lý Công việc',
  'App quản lý task'
];
const List<String> _listPriority = <String>[
  'Không ưu tiên',
  'Ưu tiên vừa',
  'Ưu tiên',
  'Cấp độ'
];

const List<String> _listStatus = <String>[
  'Coding',
  'HoldOn',
  'In progress',
  'Done'
];
// List taskDetail1 = [];
