import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/representation/screens/project_screen/project_detail.dart';
import 'package:travel_app/representation/widgets/list_project.dart';
import 'package:travel_app/representation/widgets/search_input.dart';
import 'package:travel_app/representation/widgets/select_option.dart';
import 'package:travel_app/services/project_services.dart';

import '../../../Data/models/option_modal.dart';
import '../../../Data/models/project_model.dart';
import '../../../Data/models/user_model.dart';
import '../../../core/helpers/local_storage_helper.dart';
import '../../../services/user_services.dart';

class ProjectScreen extends StatefulWidget {
  ProjectScreen({
    super.key,
    this.checkIsUser = false,
  });
  var checkIsUser;

  static const routeName = '/project_screen';

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
  // final ProjectModal projectModal;
}

class _ProjectScreenState extends State<ProjectScreen> {
  // String dropdownValue = list.first

  @override
  void initState() {
    super.initState();
    category = _list[0].value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ProjectModal projectModalEmty = ProjectModal();
  List<ProjectModal> list = [];
  List<UserModal> _listUser = [];

  late String category;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    dynamic _userLogin = LocalStorageHelper.getValue('userLogin')["id"];
    dynamic _userRule = LocalStorageHelper.getValue('userLogin')["position"];

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: getAllProjects(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            if (snapshot.hasData) {
              final projectModal = snapshot.data!;
              projectModal.map(
                (e) {},
              );
              return Text(
                "Dự án (" + projectModal.length.toString() + ")",
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        actions: [
          _userRule == "admin"
              ? InkWell(
                  child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        FontAwesomeIcons.plus,
                      )),
                  onTap: () {
                    Navigator.of(context).pushNamed(ProjectDetail.routeName,
                        arguments: projectModalEmty);
                  },
                )
              : SizedBox()
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(children: [
          SearchInput(
            controller: textEditingController,
            onChanged: (value) {
              setState(() {
                textEditingController.text = value;
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
                _listUser = snapshot.data!;

                return SizedBox();
              } else {
                return SizedBox();
              }
            },
          ),
          Row(children: [
            Expanded(
              flex: 3,
              child: SelectOption(
                searchOption: 0,
                list: _list,
                dropdownValue: category,
                onChanged: ((p0) {
                  setState(() {
                    category = p0.toString();
                  });
                }),
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: StreamBuilder(
            stream: getAllProjects(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              if (snapshot.hasData) {
                final projectModal = snapshot.data!;
                if (widget.checkIsUser) {
                  currentProjectData = [];
                  for (var e in projectModal) {
                    for (var e2 in e.users!) {
                      if (e2 == _userLogin &&
                          currentProjectData.contains(e) == false) {
                        currentProjectData.add(e);
                      }
                    }
                  }
                } else {
                  currentProjectData = searchProject(textEditingController.text,
                      category, projectModal, _listUser);
                }

                return ListView(
                  children: currentProjectData
                      .map(((e) => ListProject(
                            projectModal: e,
                          )))
                      .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ))
        ]),
      ),
    );
  }
}

List<OptionModal> _list = [
  OptionModal(value: "name", display: "Tên"),
  OptionModal(value: "userName", display: "Tên nhân viên"),
  OptionModal(value: "shortName", display: "Tên ngắn"),
];
