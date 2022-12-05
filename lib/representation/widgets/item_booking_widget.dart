import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';

class ItemBookingWidget extends StatelessWidget {
  const ItemBookingWidget(
      {super.key,
      required this.icon,
      required this.description,
      required this.title,
      this.onTap});

  final String icon;
  final String description;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(kItemPadding))),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: kDefaultPadding,
            ),
            // Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: kItemPadding,
                ),
                Text(description)
              ],
            )
          ],
        ),
      ),
    );
  }
}
