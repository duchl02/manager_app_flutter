import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/models/project_model.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/extensions/date_time_format.dart';
import 'package:travel_app/presentations/widgets/button_widget.dart';
import 'package:travel_app/presentations/widgets/form_field.dart';
import 'package:travel_app/presentations/widgets/select_multi_custom.dart';
import 'package:travel_app/services/project_services.dart';
import 'package:travel_app/services/user_services.dart';

import 'package:travel_app/core/helpers/local_storage_helper.dart';
import 'package:travel_app/services/home_services.dart';

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({super.key, required this.projectModal});

  static const String routeName = "/project_detail";

  final ProjectModal projectModal;

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  TextEditingController? nameController = TextEditingController();
  TextEditingController? shortNameController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();

  List listUsers = [];
  List listUsersId = [];

  @override
  void initState() {
    super.initState();
    listUsersId = widget.projectModal.users ?? [];
    setValue();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController!.dispose();
    shortNameController!.dispose();
    descriptionController!.dispose();
    super.dispose();
  }

  void setValue() {
    if (widget.projectModal.name != null) {
      nameController!.text = widget.projectModal.name!;
    }
    if (widget.projectModal.shortName != null) {
      shortNameController!.text = widget.projectModal.shortName!;
    }
    if (widget.projectModal.description != null) {
      descriptionController!.text = widget.projectModal.description!;
    }
    listUsers = listUsersDefault;
  }

  List<UserModal> listUsersDefault = [];

  @override
  Widget build(BuildContext context) {
    dynamic _userLoginPosition =
        LocalStorageHelper.getValue('userLogin')["position"];
    dynamic _userLoginId = LocalStorageHelper.getValue('userLogin')["id"];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectModal.createAt != null
            ? "Chỉnh sửa dự án"
            : "Thêm mới dự án"),
        actions: [
          widget.projectModal.createAt != null && _userLoginPosition == "admin"
              ? InkWell(
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.white,
                      )),
                  onTap: () async {
                    if (_userLoginPosition == "admin") {
                      if (await confirm(
                        context,
                        title: const Text('Xác nhận'),
                        content: Text('Xác nhận xóa dự án'),
                        textOK: const Text('Xác nhận'),
                        textCancel: const Text('Thoát'),
                      )) {
                        setState(() {
                          isLoading = true;
                        });
                        await deleteProject(widget.projectModal.id.toString());
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
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormInputField(
                        label: "Tên dự án",
                        hintText: "Nhập tên dự án",
                        controller: nameController,
                        validator: ((p0) {
                          if (p0 == null || p0 == "") {
                            return "Trường này không được để trống";
                          } else {
                            return null;
                          }
                        }),
                        onChanged: (value) {
                          setState(() {
                            nameController!.text = value;
                          });
                        },
                      ),
                      FormInputField(
                        label: "Tên ngắn gọn",
                        controller: shortNameController,
                        hintText: "Nhập tên",
                        validator: ((p0) {
                          if (p0 == null || p0 == "") {
                            return "Trường này không được để trống";
                          } else {
                            return null;
                          }
                        }),
                        onChanged: (value) {
                          setState(() {
                            shortNameController!.text = value;
                          });
                        },
                      ),
                      StreamBuilder(
                        stream: getAllUsers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          if (snapshot.hasData) {
                            final projectModal = snapshot.data!;
                            listUsersDefault = [];
                            for (var e in projectModal) {
                              for (var e2 in listUsersId) {
                                if (e.id == e2) {
                                  listUsersDefault.add(e);
                                }
                              }
                            }
                            return SelectMultiCustom(
                              title: "Nhân viên",
                              listValues: projectModal,
                              defaultListValues: listUsersDefault,
                              onTap: (value) {
                                listUsers = value;
                              },
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
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
                      SizedBox(
                        height: 6,
                      ),
                      widget.projectModal.createAt != null
                          ? Row(
                              children: [
                                Text(
                                  "Ngày tạo: ",
                                ),
                                Text(formatDate(widget.projectModal.createAt))
                              ],
                            )
                          : SizedBox(),
                      widget.projectModal.updateAt != null
                          ? Row(
                              children: [
                                Text(
                                  "Ngày chỉnh sửa: ",
                                ),
                                Text(formatDate(widget.projectModal.updateAt))
                              ],
                            )
                          : SizedBox(),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: ButtonWidget(
                                  isCancel: true,
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
                                  isCancel: false,
                                  title: "Xác nhận",
                                  ontap: () async {
                                    final isValidForm =
                                        _formKey.currentState!.validate();
                                    if (isValidForm) {
                                      if (_userLoginPosition == "admin") {
                                        if (listUsers != []) {
                                          listUsersId = [];
                                          for (var e in listUsers) {
                                            listUsersId.add(e.id);
                                          }
                                        }

                                        if (widget.projectModal.createAt !=
                                            null) {
                                          if (await confirm(
                                            context,
                                            title: const Text('Xác nhận'),
                                            content: Text('Xác nhận sửa dự án'),
                                            textOK: const Text('Xác nhận'),
                                            textCancel: const Text('Thoát'),
                                          )) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await updateProject(
                                                id: widget.projectModal.id
                                                    .toString(),
                                                name: nameController!.text,
                                                description:
                                                    descriptionController!.text,
                                                users: listUsersId,
                                                shortName:
                                                    shortNameController!.text,
                                                createAt: widget.projectModal
                                                        .createAt ??
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
                                            content:
                                                Text('Xác nhận thêm mới dự án'),
                                            textOK: const Text('Xác nhận'),
                                            textCancel: const Text('Thoát'),
                                          )) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await createProject(
                                                name: nameController!.text,
                                                description:
                                                    descriptionController!.text,
                                                users: listUsersId,
                                                shortName:
                                                    shortNameController!.text,
                                                createAt: widget.projectModal
                                                        .createAt ??
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
            ),
    );
  }
}
