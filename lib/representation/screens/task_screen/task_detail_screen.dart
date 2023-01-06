import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/models/option_modal.dart';
import 'package:travel_app/Data/models/task_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/extensions/date_time_format.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/form_field.dart';
import 'package:travel_app/representation/widgets/select_option.dart';
import 'package:travel_app/services/home_services.dart';
import 'package:travel_app/services/project_services.dart';
import 'package:travel_app/services/task_services.dart';

import '../../../Data/models/project_model.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/helpers/local_storage_helper.dart';
import '../../../services/user_services.dart';

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
  late String userId;
  late String projectId;
  late String priorityId;
  late String statusId;
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
    if (widget.taskModal.userId != null) {
      userId = widget.taskModal.userId!;
    }
    if (widget.taskModal.priority != null) {
      priorityId = widget.taskModal.priority!;
    }
    if (widget.taskModal.status != null) {
      statusId = widget.taskModal.status!;
    }
    if (widget.taskModal.projectId != null) {
      projectId = widget.taskModal.projectId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic _userLoginPosition =
        LocalStorageHelper.getValue('userLogin')["position"];
    dynamic _userLoginId = LocalStorageHelper.getValue('userLogin')["id"];
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
                    if (_userLoginPosition == "admin" ||
                        _userLoginId == widget.taskModal.userId ||
                        widget.taskModal.userId == null) {
                      if (await confirm(
                        context,
                        title: const Text('Xác nhận'),
                        content: Text('Xác nhận xóa task'),
                        textOK: const Text('Xác nhận'),
                        textCancel: const Text('Thoát'),
                      )) {
                        setState(() {
                          isLoading = true;
                        });
                        await deleteTask(widget.taskModal.id.toString());
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).pop();
                        await EasyLoading.showSuccess("Xóa thành công");
                      }
                    } else {
                      notAlowAction(context);
                    }
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
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 2),
                      child: Text(
                        "Người thực hiện",
                        style: TextStyle(
                            color: ColorPalette.primaryColor, fontSize: 18),
                      ),
                    ),
                    StreamBuilder(
                      stream: getAllUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.hasData) {
                          final userModal = snapshot.data!;
                          List<OptionModal> _listSatff = [];
                          var userLogin =
                              LocalStorageHelper.getValue('userLogin');
                          List<UserModal> user = [];
                          for (var e in userModal) {
                            if (e.id == userLogin["id"]) {
                              user.add(e);
                            }
                          }
                          if (userLogin["id"] != widget.taskModal.userId &&
                                  widget.taskModal.userId != null ||
                              userLogin["position"] == "admin") {
                            for (var e in userModal) {
                              _listSatff.add(
                                  OptionModal(value: e.id!, display: e.name!));
                            }
                          } else {
                            for (var e in user) {
                              _listSatff.add(
                                  OptionModal(value: e.id!, display: e.name!));
                            }
                          }

                          // UserModal userDefaults =
                          //     findUserById(userId, userModal);
                          print(userLogin["position"]);
                          return SelectOption(
                            list: _listSatff,
                            dropdownValue: widget.taskModal.userId != null
                                ? widget.taskModal.userId.toString()
                                : "",
                            onChanged: (p0) {
                              userId = p0 as String;
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
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
                    StreamBuilder(
                      stream: getAllProjects(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.hasData) {
                          final projectModal = snapshot.data!;
                          List<OptionModal> _listProject = [];
                          var userLogin =
                              LocalStorageHelper.getValue('userLogin');
                          List<ProjectModal> listTasks = [];
                          for (var e in projectModal) {
                            for (var e2 in e.users!) {
                              if (e2 == userLogin["id"]) {
                                listTasks.add(e);
                              }
                            }
                          }
                          if (userLogin["position"] == "admin") {
                            for (var e in projectModal) {
                              _listProject.add(
                                  OptionModal(value: e.id!, display: e.name!));
                            }
                          }
                          for (var e in listTasks) {
                            _listProject.add(
                                OptionModal(value: e.id!, display: e.name!));
                          }
                          return SelectOption(
                            list: _listProject,
                            dropdownValue: widget.taskModal.projectId != null
                                ? widget.taskModal.projectId.toString()
                                : "",
                            onChanged: (p0) {
                              projectId = p0 as String;
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
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
                          : "",
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
                          : "",
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
                                  if (_userLoginPosition == "admin" ||
                                      _userLoginId == widget.taskModal.userId ||
                                      widget.taskModal.userId == null) {
                                    if (widget.taskModal.createAt != null) {
                                      if (await confirm(
                                        context,
                                        title: const Text('Xác nhận'),
                                        content: Text('Xác nhận sửa task'),
                                        textOK: const Text('Xác nhận'),
                                        textCancel: const Text('Thoát'),
                                      )) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await updateTask(
                                            id: widget.taskModal.id.toString(),
                                            name: nameController!.text,
                                            description:
                                                descriptionController!.text,
                                            priority: priorityId,
                                            projectId: projectId,
                                            userId: userId,
                                            status: statusId,
                                            timeSuccess:
                                                timeSuccessController!.text,
                                            createAt:
                                                widget.taskModal.createAt ??
                                                    DateTime.now(),
                                            updateAt: DateTime.now());
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.of(context).pop();

                                        await EasyLoading.showSuccess(
                                            "Sửa thành công");
                                      }
                                    } else {
                                      if (await confirm(
                                        context,
                                        title: const Text('Xác nhận'),
                                        content: Text('Xác nhận tạo task'),
                                        textOK: const Text('Xác nhận'),
                                        textCancel: const Text('Thoát'),
                                      )) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await createTask(
                                            name: nameController!.text,
                                            description:
                                                descriptionController!.text,
                                            priority: priorityId,
                                            projectId: projectId,
                                            userId: userId,
                                            status: statusId,
                                            timeSuccess:
                                                timeSuccessController!.text,
                                            createAt:
                                                widget.taskModal.createAt ??
                                                    DateTime.now(),
                                            updateAt: DateTime.now());
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.of(context).pop();

                                        await EasyLoading.showSuccess(
                                            "Tạo thành công");
                                      }
                                    }
                                  } else {
                                    notAlowAction(context);
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

List<OptionModal> _listPriority = [
  OptionModal(value: "P1", display: "Không ưu tiên"),
  OptionModal(value: "P2", display: "Ưu tiên vừa"),
  OptionModal(value: "P3", display: "Ưu tiên"),
  OptionModal(value: "P4", display: "Cấp bách"),
];
List<OptionModal> _listStatus = [
  OptionModal(value: "S1", display: "Coding"),
  OptionModal(value: "S2", display: "HoldOn"),
  OptionModal(value: "S3", display: "In progress"),
  OptionModal(value: "S4", display: "Done"),
];
