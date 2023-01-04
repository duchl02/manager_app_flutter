import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/representation/screens/project_screen/project_detail.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/list_project.dart';
import 'package:travel_app/representation/widgets/search_input.dart';
import 'package:travel_app/representation/widgets/select_option.dart';
import 'package:travel_app/services/project_services.dart';

import '../../../Data/models/option_modal.dart';
import '../../../Data/models/project_model.dart';
import '../../../services/project_services.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({
    super.key,
  });

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
    isSearch = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isSearch = false;
  }

  final ProjectModal projectModalEmty = ProjectModal();
  List<ProjectModal> list = [];
  bool isSearch = false;
  late String category;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                // style: TextStyleCustom.h1Text,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        backgroundColor: ColorPalette.primaryColor,
        actions: [
          InkWell(
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
          SizedBox(
            height: 5,
          ),
          Row(children: [
            Expanded(
              flex: 3,
              child: SelectOption(
                searchOption: 0,
                list: _list,
                dropdownValue: category,
                onChanged: ((p0) {
                  category = p0.toString();
                }),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 2,
                child: ButtonWidget(
                  title: "Tìm kiếm",
                  ontap: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                ))
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
                currentProjectData = searchProject(
                    textEditingController.text, category, projectModal);
                if (isSearch == false) {
                  return ListView(
                    children: projectModal
                        .map(((e) => ListProject(
                              projectModal: e,
                            )))
                        .toList(),
                  );
                } else {
                  return ListView(
                    children: currentProjectData
                        .map(((e) => ListProject(
                              projectModal: e,
                            )))
                        .toList(),
                  );
                }
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
  OptionModal(value: "task", display: "Tên task"),
];
