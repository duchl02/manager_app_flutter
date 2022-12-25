import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';

import '../../../core/constants/dismension_constants.dart';
import '../../../core/helpers/asset_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../widgets/app_bar_container.dart';
import '../../widgets/list_task.dart';

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
                    height: kMinPadding,
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
                child: ImageHelper.loadFromAsset(AssetHelper.catCute),
              )
            ],
          ),
        ),
        titleString: "home",
        isHomePage: true,
        child: Column(children: [
          SizedBox(
            height: kDefaultPadding * 3,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildItemCategory(
                    Icon(FontAwesomeIcons.plus), () {}, 'Điểm danh'),
              ),
              Expanded(
                child: _buildItemCategory(
                    Icon(FontAwesomeIcons.calendar), () {}, 'Lịch làm việc'),
              ),
              Expanded(
                child: _buildItemCategory(
                    Icon(FontAwesomeIcons.list), () {}, 'Thêm task'),
              ),
              Expanded(
                child: _buildItemCategory(Icon(FontAwesomeIcons.userLargeSlash),
                    () {}, 'Đăng ký nghỉ phép'),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Danh sách task",
                  style: TextStyleCustom.h2TextPrimary,
                ),
                Icon(
                  FontAwesomeIcons.arrowRight,
                  size: 16,
                  color: ColorPalette.primaryColor,
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: const [
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
                listTask(),
              ]),
            ),
          ),
        ]));
  }

  Widget _buildItemCategory(Icon icon, Function() onTap, String title) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(vertical: kMediumPadding, horizontal: 24),
            decoration: BoxDecoration(
                color: ColorPalette.secondColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(kItemPadding)),
            child: icon,
          ),
          SizedBox(
            height: kItemPadding,
          ),
          Text(
            title,
            style: TextStyleCustom.nomalTextPrimary,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
