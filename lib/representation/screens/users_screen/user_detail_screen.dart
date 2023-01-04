import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/models/option_modal.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/extensions/date_time_format.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/form_field.dart';
import 'package:travel_app/representation/widgets/selectMultiCustom.dart';
import 'package:travel_app/services/project_services.dart';
import 'package:travel_app/services/user_services.dart';
import 'package:travel_app/services/task_services.dart';

import '../../../core/constants/color_constants.dart';
import '../../widgets/select_option.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key, required this.userModal});

  static const String routeName = "/user_detail";

  final UserModal userModal;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  bool isLoading = false;
  TextEditingController? nameController = TextEditingController();
  TextEditingController? userNameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? birthdayController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? idNumberController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? phoneNumberController = TextEditingController();

  List listProject = [];
  List listProjectsId = [];
  String positionId = "";

  @override
  void initState() {
    super.initState();
    // listUsersId = widget.userModal.users ?? [];
    setValue();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController!.dispose();
    userNameController!.dispose();
    passwordController!.dispose();
    birthdayController!.dispose();
    addressController!.dispose();
    idNumberController!.dispose();
    emailController!.dispose();
    super.dispose();
  }

  void setValue() {
    if (widget.userModal.name != null) {
      nameController!.text = widget.userModal.name!;
    }
    if (widget.userModal.password != null) {
      passwordController!.text = widget.userModal.password!;
    }
    if (widget.userModal.birthday != null) {
      birthdayController!.text = formatDate(widget.userModal.birthday);
    }
    if (widget.userModal.userName != null) {
      userNameController!.text = widget.userModal.userName!;
    }
    if (widget.userModal.idNumber != null) {
      idNumberController!.text = widget.userModal.idNumber!;
    }
    if (widget.userModal.email != null) {
      emailController!.text = widget.userModal.email!;
    }
    if (widget.userModal.phoneNumber != null) {
      phoneNumberController!.text = widget.userModal.phoneNumber!;
    }
    if (widget.userModal.address != null) {
      addressController!.text = widget.userModal.address!;
    }
    if (widget.userModal.position != null) {
      positionId = widget.userModal.position!;
    }
    if (widget.userModal.birthday != null) {
      dateTime = widget.userModal.birthday!;
    }
    if (widget.userModal.projects != null) {
      listProjectsId = widget.userModal.projects!;
    }
  }

  List listProjectsDefault = [];

  late DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text(widget.userModal.createAt != null
            ? "Chỉnh sửa nhân viên"
            : "Thêm mới nhân viên"),
        actions: [
          widget.userModal.createAt != null
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
                    await deleteUser(widget.userModal.id.toString());
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
                        Text(widget.userModal.createAt != null
                            ? formatDate(widget.userModal.createAt)
                            : "Chưa có")
                      ],
                    ),
                    Row(
                      children: [
                        Text("Ngày chỉnh sửa: "),
                        Text(widget.userModal.updateAt != null
                            ? formatDate(widget.userModal.updateAt)
                            : "Chưa có")
                      ],
                    ),
                    FormInputField(
                      label: "Họ và tên",
                      hintText: "Nhập họ và tên",
                      controller: nameController,
                      onChanged: (value) {
                        setState(() {
                          nameController!.text = value;
                        });
                      },
                    ),

                    FormInputField(
                      label: "User name",
                      controller: userNameController,
                      hintText: "Nhập user name",
                      onChanged: (value) {
                        setState(() {
                          userNameController!.text = value;
                        });
                      },
                    ),
                    FormInputField(
                      label: "Mật khẩu",
                      controller: passwordController,
                      hintText: "Nhập mật khẩu",
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          passwordController!.text = value;
                        });
                      },
                    ),
                    FormInputField(
                      label: "Ngày sinh",
                      controller: birthdayController,
                      hintText: "Chọn ngày sinh",
                      onTap: () async {
                        final dateData = await pickDate();
                        if (dateData == null) {
                          return;
                        }
                        setState(() {
                          dateTime = dateData;
                          birthdayController!.text =
                              "${dateTime.day} - ${dateTime.month} - ${dateTime.year}";
                        });
                      },
                      // onChanged: (value) {
                      //   setState(() {
                      //     birthdayController!.text = value;
                      //   });
                      // },
                    ),
                    FormInputField(
                      label: "Địa chỉ",
                      controller: addressController,
                      hintText: "Nhập địa chỉ",
                      onChanged: (value) {
                        setState(() {
                          addressController!.text = value;
                        });
                      },
                    ),
                    FormInputField(
                      label: "Số điện thoại",
                      controller: phoneNumberController,
                      hintText: "Nhập số điện thoại",
                      onChanged: (value) {
                        setState(() {
                          phoneNumberController!.text = value;
                        });
                      },
                    ),
                    FormInputField(
                      label: "CMND",
                      controller: idNumberController,
                      hintText: "Nhập CMND",
                      onChanged: (value) {
                        setState(() {
                          idNumberController!.text = value;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 2),
                      child: Text(
                        "Vị trí",
                        style: TextStyle(
                            color: ColorPalette.primaryColor, fontSize: 18),
                      ),
                    ),
                    SelectOption(
                      list: _listPositions,
                      dropdownValue: widget.userModal.position != null
                          ? widget.userModal.position.toString()
                          : _listPositions[0].value,
                      onChanged: (p0) {
                        positionId = p0 as String;
                      },
                    ),
                    FormInputField(
                      label: "Email",
                      controller: emailController,
                      hintText: "Nhập email",
                      onChanged: (value) {
                        setState(() {
                          emailController!.text = value;
                        });
                      },
                    ),
                    // FormInputField(label: "Người thực hiện", hintText: "Nhập tiêu đề"),

                    StreamBuilder(
                      stream: getAllProjects(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.hasData) {
                          final projectModal = snapshot.data!;
                          listProjectsDefault = [];
                          for (var e in projectModal) {
                            for (var e2 in listProjectsId) {
                              if (e.id == e2) {
                                listProjectsDefault.add(e);
                              }
                            }
                          }
                          return SelectMultiCustom(
                            title: "Dự án",
                            listValues: projectModal,
                            defaultListValues: listProjectsDefault,
                            onTap: (value) {
                              listProject = value;
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),

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
                            width: kDefaultPadding,
                          ),
                          Flexible(
                              flex: 1,
                              child: ButtonWidget(
                                title: "Xác nhận",
                                ontap: () async {
                                  if (listProject != [] && listProject.length != 0) {
                                    listProjectsId = [];
                                    for (var e in listProject) {
                                      listProjectsId.add(e.id);
                                    }
                                  }
                                  if (widget.userModal.createAt != null) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await updateUser(
                                        id: widget.userModal.id.toString(),
                                        name: nameController!.text,
                                        userName: userNameController!.text,
                                        password: passwordController!.text,
                                        birthday: dateTime,
                                        idNumber: idNumberController!.text,
                                        position: positionId,
                                        projects: listProjectsId,
                                        phoneNumber:
                                            phoneNumberController!.text,
                                        email: emailController!.text,
                                        address: addressController!.text,
                                        createAt: widget.userModal.createAt ??
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
                                    await createUser(
                                        name: nameController!.text,
                                        userName: userNameController!.text,
                                        password: passwordController!.text,
                                        birthday: dateTime,
                                        idNumber: idNumberController!.text,
                                        address: addressController!.text,
                                        phoneNumber:
                                            phoneNumberController!.text,
                                        position: positionId,
                                        email: emailController!.text,
                                        createAt: widget.userModal.createAt ??
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

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
}

List<OptionModal> _listPositions = [
  OptionModal(value: "NV", display: "Nhân viên"),
  OptionModal(value: "Quản lý", display: "Quản lý"),
  OptionModal(value: "Admin", display: "Admin"),
];
