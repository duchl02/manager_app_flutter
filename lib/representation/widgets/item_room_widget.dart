import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/Data/models/hotel_modal.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/dash_line.dart';
import 'package:travel_app/representation/widgets/item_utility_hotel.dart';

import '../../Data/models/room_model.dart';
import '../../core/constants/textstyle_ext.dart';

class ItemRoomWidget extends StatelessWidget {
  const ItemRoomWidget({
    super.key,
    required this.roomModel,
    this.onTap,
    this.numberOfRoom,
  });

  // static const routeName = "/item_room_widget";

  final RoomModel roomModel;
  final Function()? onTap;
  final int? numberOfRoom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding),
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(kItemPadding))),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roomModel.roomName,
                        style: TextStyles.defaultStyle.fontHeader.bold,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        'Room Size: ${roomModel.size} m2',
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        roomModel.utility,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ImageHelper.loadFromAsset(roomModel.roomImage,
                      radius: BorderRadius.circular(kItemPadding)),
                ),
              ],
            ),
            ItemUtilityHotelWidget(),
            DashLineWidget(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$${roomModel.price.toString()}',
                        style: TextStyles.defaultStyle.fontHeader.bold),
                    SizedBox(
                      height: kMinPadding,
                    ),
                    Text('/night', style: TextStyles.defaultStyle.fontCaption),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: numberOfRoom == null
                      ? ButtonWidget(
                          title: 'Choose',
                          ontap: onTap,
                        )
                      : Text(
                          '$numberOfRoom room',
                          textAlign: TextAlign.end,
                        ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
