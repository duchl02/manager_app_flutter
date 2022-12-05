import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';

class AppBarContainerWidget extends StatelessWidget {
  const AppBarContainerWidget(
      {super.key,
      required this.child,
      this.title,
      this.implementLoading = true,
      this.titleString,
      this.implementTraveling = false});

  final Widget child;
  final Widget? title;
  final bool implementLoading;
  final String? titleString;
  final bool implementTraveling;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 187,
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 90,
              backgroundColor: ColorPalette.backgroundScaffoldColor,
              title: title ??
                  Row(
                    children: [
                      if (implementLoading)
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
                          Text(titleString ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))
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
                        )
                    ],
                  ),
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: Gradients.defaultGradientBackground,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(35))),
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
          Container(
            margin: EdgeInsets.only(top: 156),
            child: child,
            padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
          )
        ],
      ),
    );
  }
}
