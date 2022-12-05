import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/representation/screens/check_out_screen.dart';
import 'package:travel_app/representation/screens/home_booking_screen.dart';
import 'package:travel_app/representation/screens/main_app.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';

import '../../Data/models/room_model.dart';
import '../../core/helpers/asset_helper.dart';
import '../widgets/item_room_widget.dart';
import 'hotel_screen.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  static const String routeName = '/rooms_screen';

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final List<RoomModel> listRoom = [
    RoomModel(
      roomImage: AssetHelper.room1,
      roomName: 'Deluxe Room',
      size: 27,
      utility: 'Free Cancellation',
      price: 245,
    ),
    RoomModel(
      roomImage: AssetHelper.room2,
      roomName: 'Executive Suite',
      size: 32,
      utility: 'Non-refundable',
      price: 289,
    ),
    RoomModel(
      roomImage: AssetHelper.room3,
      roomName: 'King Bed Only Room',
      size: 24,
      utility: 'Non-refundable',
      price: 214,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: "Select room",
      child: SingleChildScrollView(
          child: Column(children: [
        SizedBox(
          height: kItemPadding * 5,
        ),
        Column(
          children: listRoom
              .map(
                (e) => ItemRoomWidget(
                  roomModel: e,
                  onTap: () {
                    Navigator.of(context).popUntil(
                        (route) => route.settings.name == MainApp.routeName);
                  },
                ),
              )
              .toList(),
        )
      ])),
    );
  }
}
