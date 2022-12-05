import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';

import '../../core/helpers/asset_helper.dart';
import '../widgets/add_guest_and_bed_widget.dart';

class GuestAndRoomBookingScreen extends StatefulWidget {
  const GuestAndRoomBookingScreen({super.key});

  static const routeName = "/add_guest_and_room";

  @override
  State<GuestAndRoomBookingScreen> createState() =>
      _GuestAndRoomBookingScreenState();
}

class _GuestAndRoomBookingScreenState extends State<GuestAndRoomBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: "Add Guest and Room",
      child: Column(
        children: [
          SizedBox(
            height: kMediumPadding * 2,
          ),
          AddGuestAndRoom(
            // key: _itemCountGuest,
            initData: 1,
            icon: AssetHelper.icoGuest,
            title: 'Guest',
          ),
          AddGuestAndRoom(
            // key: _itemCountGuest,
            initData: 1,
            icon: AssetHelper.icoRoom,
            title: 'Guest',
          )
        ],
      ),
    );
  }
}
