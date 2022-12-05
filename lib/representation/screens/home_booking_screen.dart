import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/representation/screens/Guest_and_room_booking_screen.dart';
import 'package:travel_app/representation/screens/hotel_screen.dart';
import 'package:travel_app/representation/screens/select_date_screen.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';
import 'package:travel_app/representation/widgets/item_booking_widget.dart';
import 'package:travel_app/core/extensions/date_ext.dart';

class HomeBookingScreen extends StatefulWidget {
  const HomeBookingScreen({super.key});

  static const String routeName = "/home_booking_screen";

  @override
  State<HomeBookingScreen> createState() => _HomeBookingScreenState();
}

class _HomeBookingScreenState extends State<HomeBookingScreen> {
  String? selectDate;
  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: "Hotel Booking Screen",
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: kMediumPadding * 2,
          ),
          ItemBookingWidget(
            icon: AssetHelper.icoLocation,
            description: "Destination",
            title: "Viet Nam",
            onTap: () {},
          ),
          SizedBox(
            height: kMediumPadding,
          ),
          ItemBookingWidget(
            title: 'Select Date',
            description: selectDate ?? 'Select date',
            icon: AssetHelper.icoCalendal,
            onTap: () async {
              final result = await Navigator.of(context)
                  .pushNamed(SelectDateScreen.routeName);
              if (result is List<DateTime?>) {
                setState(() {
                  selectDate =
                      '${result[0]?.getStartDate} - ${result[1]?.getEndDate}';
                });
              }
            },
          ),
          SizedBox(
            height: kMediumPadding,
          ),
          ItemBookingWidget(
            icon: AssetHelper.icoBed,
            description: "Guest and room",
            title: "2 Guest, 1 Room",
            onTap: () {
              Navigator.of(context)
                  .pushNamed(GuestAndRoomBookingScreen.routeName);
            },
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          ButtonWidget(
            title: "Search",
            ontap: () {
              Navigator.of(context).pushNamed(HotelScreen.routeName);
            },
          ),
        ],
      )),
    );
  }
}
