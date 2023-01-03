import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/extensions/date_time_format.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/form_field.dart';
import 'package:travel_app/representation/widgets/select_option.dart';
import 'package:travel_app/services/task_services.dart';

import '../../../core/constants/color_constants.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key, required this.taskModal});

  static const String routeName = "/task_detail";

  final TaskModal taskModal;

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  bool isLoading = false;
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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController!.dispose();
    timeSuccessController!.dispose();
    descriptionController!.dispose();
    super.dispose();
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
    print(widget.taskModal.toJson());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text(widget.taskModal.createAt != null
            ? "Chỉnh sửa task"
            : "Thêm mới task"),
        actions: [
          widget.taskModal.createAt != null
              ? InkWell(
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.white,
                      )),
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await deleteTask(widget.taskModal.id.toString());
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                    await EasyLoading.showSuccess("Xóa thành công");
                  },
                )
              : Text("")
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Ngày tạo: "),
                        Text(widget.taskModal.createAt != null
                            ? formatDate(widget.taskModal.createAt)
                            : "Chưa có")
                      ],
                    ),
                    Row(
                      children: [
                        Text("Ngày chỉnh sửa: "),
                        Text(widget.taskModal.updateAt != null
                            ? formatDate(widget.taskModal.updateAt)
                            : "Chưa có")
                      ],
                    ),
                    FormInputField(
                      label: "Tiêu đề",
                      hintText: "Nhập tiêu đề",
                      controller: nameController,
                      onChanged: (value) {
                        setState(() {
                          nameController!.text = value;
                        });
                      },
                    ),
                    // FormInputField(label: "Người thực hiện", hintText: "Nhập tiêu đề"),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 2),
                      child: Text(
                        "Người thực hiện",
                        style: TextStyle(
                            color: ColorPalette.primaryColor, fontSize: 18),
                      ),
                    ),
                    SelectOption(
                      list: _listSatff,
                      dropdownValue: widget.taskModal.userId != null
                          ? widget.taskModal.userId.toString()
                          : _listSatff[0],
                      onChanged: (p0) {
                        userId = p0 as String;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 2),
                      child: Text(
                        "Dự án",
                        style: TextStyle(
                            color: ColorPalette.primaryColor, fontSize: 18),
                      ),
                    ),
                    SelectOption(
                      list: _listProject,
                      dropdownValue:
                          widget.taskModal.projectId ?? _listProject[0],
                      onChanged: (p0) {
                        projectId = p0 as String;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 2),
                      child: Text(
                        "Độ ưu tiên",
                        style: TextStyle(
                            color: ColorPalette.primaryColor, fontSize: 18),
                      ),
                    ),
                    SelectOption(
                      list: _listPriority,
                      dropdownValue: widget.taskModal.priority != null
                          ? widget.taskModal.priority.toString()
                          : _listPriority[0],
                      onChanged: (p0) {
                        priorityId = p0 as String;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 2),
                      child: Text(
                        "Trạng thái",
                        style: TextStyle(
                            color: ColorPalette.primaryColor, fontSize: 18),
                      ),
                    ),
                    SelectOption(
                      list: _listStatus,
                      dropdownValue: widget.taskModal.status != null
                          ? widget.taskModal.status.toString()
                          : _listStatus[0],
                      onChanged: (p0) {
                        statusId = p0 as String;
                      },
                    ),
                    FormInputField(
                      label: "Thời gian hoàn thành",
                      controller: timeSuccessController,
                      hintText: "Nhập số giờ",
                      onChanged: (value) {
                        setState(() {
                          timeSuccessController!.text = value;
                        });
                      },
                    ),
                    FormInputField(
                      label: "Mô tả",
                      hintText: "Nhập mô tả",
                      maxLines: 3,
                      controller: descriptionController,
                      onChanged: (value) {
                        setState(() {
                          descriptionController!.text = value;
                        });
                      },
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
                                  if (widget.taskModal.createAt != null) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await updateTask(
                                        id: widget.taskModal.id.toString(),
                                        name:
                                            nameController!.text ?? "Khong co",
                                        description:
                                            descriptionController!.text ??
                                                "trong",
                                        priority: priorityId,
                                        projectId: projectId,
                                        userId: userId,
                                        status: statusId,
                                        timeSuccess:
                                            timeSuccessController!.text ??
                                                "Trong",
                                        createAt: widget.taskModal.createAt ??
                                            DateTime.now(),
                                        updateAt: DateTime.now());
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context).pop();

                                    await EasyLoading.showSuccess(
                                        "Sửa thành công");
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await createTask(
                                        name:
                                            nameController!.text ?? "Khong co",
                                        description:
                                            descriptionController!.text ??
                                                "trong",
                                        priority: priorityId,
                                        projectId: projectId,
                                        userId: userId,
                                        status: statusId,
                                        timeSuccess:
                                            timeSuccessController!.text ??
                                                "Trong",
                                        createAt: widget.taskModal.createAt ??
                                            DateTime.now(),
                                        updateAt: DateTime.now());
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context).pop();

                                    await EasyLoading.showSuccess(
                                        "Tạo thành công");
                                  }
                                },
                              )),
                        ],
                      ),
                    )
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
