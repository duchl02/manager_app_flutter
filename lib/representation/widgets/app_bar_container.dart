import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/services/project_services.dart';
import 'package:travel_app/services/task_services.dart';
import 'package:travel_app/services/user_services.dart';

class AppBarContainerWidget extends StatelessWidget {
  const AppBarContainerWidget(
      {super.key,
      required this.child,
      this.title,
      this.implementLoading = true,
      this.titleString,
      this.implementTraveling = false,
      this.isHomePage = false,
      this.description,
      this.titleCount});

  final Widget child;
  final Widget? title;
  final bool implementLoading;
  final String? titleString;
  final bool implementTraveling;
  final bool? isHomePage;
  final String? description;
  final String? titleCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: isHomePage! ? 187 : 120,
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 100,
              backgroundColor: ColorPalette.backgroundScaffoldColor,
              title: title ??
                  Row(
                    children: [
                      if (implementLoading && isHomePage!)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(kDefaultPadding)),
                                color: Colors.white),
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.black,
                              size: kDefaultIconSize,
                            ),
                          ),
                        ),
                      Expanded(
                          child: Center(
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(titleString ?? "",
                                      style: TextStyle(fontSize: 20)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(titleCount ?? "",
                                      style: TextStyle(fontSize: 20)),
                                ]),
                          ),
                          Text(description ?? "",
                              style: TextStyle(fontSize: 16)),
                        ]),
                      )),
                      if (implementTraveling)
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding),
                              color: Colors.white),
                          padding: EdgeInsets.all(kDefaultPadding),
                          child: Icon(
                            FontAwesomeIcons.bars,
                            size: kDefaultPadding,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: Gradients.defaultGradientBackground,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35))),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: ImageHelper.loadFromAsset(AssetHelper.icoOvalTop)),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child:
                          ImageHelper.loadFromAsset(AssetHelper.icoOvalBottom)),
                ],
              ),
            ),
          ),
          // if (isHomePage!)
          Container(
            margin: EdgeInsets.only(top: 156),
            child: child,
            padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
          ),
          // if (isHomePage == false)
          //   Container(
          //     margin: EdgeInsets.only(top: 40),
          //     child: child,
          //     padding: EdgeInsets.symmetric(horizontal: kItemPadding),
          //   ),
          if (isHomePage!)
            Container(
              margin: EdgeInsets.only(top: 120),
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Row(
                children: [
                  countNavBar("Điểm danh", getAllUsers()),
                  countNavBar("Task", getAllTasks()),
                  countNavBar("Dự án", getAllProjects()),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Expanded countNavBar(String name, Stream<List<dynamic>> nameCount) {
    return Expanded(
        child: Column(
      children: [
        StreamBuilder(
          stream: nameCount,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            if (snapshot.hasData) {
              final taskModal = snapshot.data!;
              // if (taskModal.checkIn != null){
              //    return Text(
              //   taskModal.checkIn.length.toString(),
              //   style: TextStyleCustom.h1Text,
              // );
              // }
              return Text( 
                taskModal.length.toString() ,
                style: TextStyleCustom.h1Text,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Text(
          name,
          style: TextStyleCustom.nomalTextWhile,
        ),
      ],
    ));
  }
}
