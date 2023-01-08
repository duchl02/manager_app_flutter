import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/Data/models/option_modal.dart';
import 'package:travel_app/Data/models/user_model.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/extensions/date_time_format.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/form_field.dart';
import 'package:travel_app/representation/widgets/select_multi_custom.dart';
import 'package:travel_app/services/project_services.dart';
import 'package:travel_app/services/user_services.dart';
import 'package:travel_app/services/task_services.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/helpers/asset_helper.dart';
import '../../../core/helpers/local_storage_helper.dart';
import '../../../services/home_services.dart';
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
    if (widget.userModal.imageUser != null) {
      imagePath = widget.userModal.imageUser!;
    }
  }

  List listProjectsDefault = [];

  late DateTime dateTime = DateTime.now();
  File? file;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    dynamic _userLoginPosition =
        LocalStorageHelper.getValue('userLogin')["position"];
    dynamic _userLoginId = LocalStorageHelper.getValue('userLogin')["id"];
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
                    if (_userLoginPosition == "admin") {
                      if (await confirm(
                        context,
                        title: const Text('Xác nhận'),
                        content: Text('Xác nhận xóa nhân viên'),
                        textOK: const Text('Xác nhận'),
                        textCancel: const Text('Thoát'),
                      )) {
                        setState(() {
                          isLoading = true;
                        });
                        await deleteUser(widget.userModal.id.toString());
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
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Center(
                    //   child: Container(
                    //     width: 100,
                    //     height: 100,
                    //     decoration: BoxDecoration(
                    //         image: DecorationImage(
                    //             image: AssetImage(imagePath),
                    //             fit: BoxFit.cover)),
                    //   ),
                    // ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          chooseImage();
                        },
                        child: Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.black),
                            shape: BoxShape.circle,
                            image: file == null
                                ? imagePath == null
                                    ? DecorationImage(
                                        image: AssetImage(AssetHelper.user),
                                        fit: BoxFit.cover)
                                    : DecorationImage(
                                        image: NetworkImage(imagePath!),
                                        fit: BoxFit.cover)
                                : DecorationImage(
                                    image: FileImage(file!), fit: BoxFit.cover),
                          ),
                          alignment: Alignment.center,
                          child: Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue,
                              ),
                              margin: EdgeInsets.only(
                                  left: 110, top: 120, right: 10),
                              child: Icon(
                                Icons.edit,
                                size: 20,
                              )),
                        ),
                      ),
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
                    
                    SelectOption(
                      label: 'Vị trí',
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
                    Row(
                      children: [
                        Text(
                          "Ngày tạo: ",
                          style: TextStyle(color: ColorPalette.subTitleColor),
                        ),
                        Text(
                          widget.userModal.createAt != null
                              ? formatDate(widget.userModal.createAt)
                              : "Chưa có",
                          style: TextStyle(color: ColorPalette.subTitleColor),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Ngày chỉnh sửa: ",
                          style: TextStyle(color: ColorPalette.subTitleColor),
                        ),
                        Text(
                          widget.userModal.updateAt != null
                              ? formatDate(widget.userModal.updateAt)
                              : "Chưa có",
                          style: TextStyle(color: ColorPalette.subTitleColor),
                        )
                      ],
                    ),
                    // FormInputField(label: "Người thực hiện", hintText: "Nhập tiêu đề"),

                    // StreamBuilder(
                    //   stream: getAllProjects(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasError) {
                    //       return Text("${snapshot.error}");
                    //     }
                    //     if (snapshot.hasData) {
                    //       final projectModal = snapshot.data!;
                    //       listProjectsDefault = [];
                    //       for (var e in projectModal) {
                    //         for (var e2 in listProjectsId) {
                    //           if (e.id == e2) {
                    //             listProjectsDefault.add(e);
                    //           }
                    //         }
                    //       }
                    //       return SelectMultiCustom(
                    //         title: "Dự án",
                    //         listValues: projectModal,
                    //         defaultListValues: listProjectsDefault,
                    //         onTap: (value) {
                    //           listProject = value;
                    //         },
                    //       );
                    //     } else {
                    //       return Center(child: CircularProgressIndicator());
                    //     }
                    //   },
                    // ),

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
                                  if (_userLoginPosition == "admin" ||
                                      _userLoginId == widget.userModal.id ||
                                      widget.userModal.id == null) {
                                    if (listProject != [] &&
                                        listProject.length != 0) {
                                      listProjectsId = [];
                                      for (var e in listProject) {
                                        listProjectsId.add(e.id);
                                      }
                                    }
                                    if (widget.userModal.createAt != null) {
                                      if (await confirm(
                                        context,
                                        title: const Text('Xác nhận'),
                                        content: Text('Xác nhận sửa nhân viên'),
                                        textOK: const Text('Xác nhận'),
                                        textCancel: const Text('Thoát'),
                                      )) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        String? url;
                                        if (file != null) {
                                          url = await uploadImage();
                                        } else {
                                          url = widget.userModal.imageUser;
                                        }

                                        await updateUser(
                                            imageUser: url,
                                            id: widget.userModal.id.toString(),
                                            name: nameController!.text,
                                            userName: userNameController!.text,
                                            password: passwordController!.text,
                                            birthday: dateTime,
                                            idNumber: idNumberController!.text,
                                            position: positionId,
                                            // projects: listProjectsId,
                                            checkIn:
                                                widget.userModal.checkIn ?? [],
                                            phoneNumber:
                                                phoneNumberController!.text,
                                            email: emailController!.text,
                                            address: addressController!.text,
                                            createAt:
                                                widget.userModal.createAt ??
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
                                            Text('Xác nhận tạo mới nhân viên'),
                                        textOK: const Text('Xác nhận'),
                                        textCancel: const Text('Thoát'),
                                      )) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        String? url;

                                        if (file != null) {
                                          url = await uploadImage();
                                        } else {
                                          url = widget.userModal.imageUser;
                                        }

                                        await createUser(
                                            imageUser: url,
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
                                            createAt:
                                                widget.userModal.createAt ??
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

  void chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);

    print('xFile + ${xfile?.path}');

    file = File(xfile!.path);
    setState(() {});
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child('profile')
        .child(
            '${FirebaseFirestore.instance.collection("users").id}_${widget.userModal.id}')
        .putFile(file!);
    print(' 11 ${taskSnapshot.ref.getDownloadURL()}');
    return taskSnapshot.ref.getDownloadURL();
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
}

List<OptionModal> _listPositions = [
  OptionModal(value: "user", display: "Nhân viên"),
  OptionModal(value: "manager", display: "Quản lý"),
  OptionModal(value: "admin", display: "Admin"),
];
