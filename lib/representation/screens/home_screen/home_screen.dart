import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';

import '../../../Data/models/task_model.dart';
import '../../../core/constants/dismension_constants.dart';
import '../../../core/helpers/asset_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../../services/services.dart';
import '../../widgets/app_bar_container.dart';
import '../../widgets/list_task.dart';
import '../select_date_screen.dart';
import '../task_screen/task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskModal taskModalEmty = new TaskModal();

  @override
  Widget build(BuildContext context) {
    getAllTasks();
    getTask();
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
                child: _buildItemCategory(Icon(FontAwesomeIcons.plus), () {
                  Navigator.of(context).pushNamed(SelectDateScreen.routeName);
                }, 'Điểm danh'),
              ),
              Expanded(
                child: _buildItemCategory(Icon(FontAwesomeIcons.calendar), () {
                  Navigator.of(context).pushNamed(SelectDateScreen.routeName);
                }, 'Lịch làm việc'),
              ),
              Expanded(
                child: _buildItemCategory(Icon(FontAwesomeIcons.list), () {
                  Navigator.of(context).pushNamed(TaskDetail.routeName,
                      arguments: taskModalEmty);
                }, 'Thêm task'),
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
            child: StreamBuilder(
              stream: getAllTasks(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("ádasdasdasd");
                  return Text("${snapshot.error}");
                }
                if (snapshot.hasData) {
                  final taskModal = snapshot.data!;
                  taskModal.map(
                    (e) {
                      print(e.show());
                    },
                  );
                  return ListView(
                    children: taskModal.map(buildUser).toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ]));
  }

  Widget buildUser(TaskModal taskModal) => ListTile(
        leading: CircleAvatar(
            child: Text(taskModal.name != null ? "${taskModal.name}" : "Null")),
        title: Text(taskModal.description ?? "description null"),
        // subtitle: Text(taskModal.createAt!.toIso8601String() ?? DateTime.now().toIso8601String()),
        subtitle: Text(taskModal.createAt != null ? taskModal.createAt!.toIso8601String() : "is null"),
      );
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
