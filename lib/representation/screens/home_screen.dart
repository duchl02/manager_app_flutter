import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/helpers/asset_helper.dart';
import '../../core/helpers/image_helper.dart';
import '../widgets/app_bar_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: kMinPadding),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Xin Chào",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Text("Nguyễn Văn Đức",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Spacer(),
              Icon(
                FontAwesomeIcons.bell,
                size: kDefaultIconSize,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kMinPadding),
                  color: Colors.white,
                ),
                child: ImageHelper.loadFromAsset(AssetHelper.person),
              )
            ],
          ),
        ),
        titleString: "home",
        isHomePage: true,
        child: Column(children: const [
          SizedBox(
            height: kDefaultPadding,
          ),
        ]));
  }
}
