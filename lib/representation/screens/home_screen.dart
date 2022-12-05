import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/representation/screens/home_booking_screen.dart';
import 'package:travel_app/representation/screens/hotel_screen.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';

import '../../core/constants/textstyle_ext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> listImageLeft = [
    {
      'name': 'Korea',
      'image': AssetHelper.korea,
    },
    {
      'name': 'Dubai',
      'image': AssetHelper.dubai,
    },
  ];
  final List<Map<String, String>> listImageRight = [
    {
      'name': 'Turkey',
      'image': AssetHelper.turkey,
    },
    {
      'name': 'Japan',
      'image': AssetHelper.japan,
    },
  ];
  Widget _buildItemCategory(
      Widget icon, Color color, Function() onTap, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: kMediumPadding),
          decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(kDefaultPadding)),
          child: icon,
        ),
        SizedBox(
          height: kItemPadding,
        ),
        Text(title)
      ]),
    );
  }

  Widget _buidlImageHomScreen(String name, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(HomeBookingScreen.routeName, arguments: name);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ImageHelper.loadFromAsset(
              image,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              radius: BorderRadius.circular(kItemPadding),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            Positioned(
              left: kDefaultPadding,
              bottom: kDefaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyles.defaultStyle.whiteTextColor.bold,
                  ),
                  SizedBox(
                    height: kItemPadding,
                  ),
                  Container(
                    padding: EdgeInsets.all(kMinPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMinPadding),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Color(0xffFFC107),
                        ),
                        SizedBox(
                          width: kItemPadding,
                        ),
                        Text('4.5')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                Text("hello",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Text("hello lan 2",
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
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Search your places",
              prefixIcon: Padding(
                padding: EdgeInsets.all(kTopPadding),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.black,
                  size: kDefaultPadding,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius:
                      BorderRadius.all(Radius.circular(kItemPadding))),
              contentPadding: EdgeInsets.symmetric(horizontal: kItemPadding)),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Row(
          children: [
            Expanded(
                child: _buildItemCategory(
                    ImageHelper.loadFromAsset(AssetHelper.icoHotel,
                        width: kDefaultIconSize, height: kDefaultPadding),
                    Color(0xffFE9C5E), () {
              Navigator.of(context).pushNamed(HomeBookingScreen.routeName);
            }, "Hotel")),
            SizedBox(
              width: kDefaultPadding,
            ),
            Expanded(
                child: _buildItemCategory(
                    ImageHelper.loadFromAsset(AssetHelper.icoPlane,
                        width: kDefaultIconSize, height: kDefaultPadding),
                    Color(0xffF77777), () {
              Navigator.of(context).pushNamed(HotelScreen.routeName);
            }, "Flights")),
            SizedBox(
              width: kDefaultPadding,
            ),
            Expanded(
              child: _buildItemCategory(
                  ImageHelper.loadFromAsset(AssetHelper.icoHotelPlane,
                      width: kDefaultIconSize, height: kDefaultPadding),
                  Color(0xff3EC8BC),
                  () {},
                  "All"),
            ),
          ],
        ),
        SizedBox(
          height: kMediumPadding,
        ),
        Row(
          children: [
            Text(
              'Popular Destinations',
              style: TextStyles.defaultStyle.bold,
            ),
            Spacer(),
            Text(
              'See All',
              style: TextStyles.defaultStyle.bold.primaryTextColor,
            ),
          ],
        ),
        SizedBox(
          height: kMediumPadding,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: listImageLeft
                        .map(
                          (e) => _buidlImageHomScreen(
                            e['name']!,
                            e['image']!,
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Expanded(
                  child: Column(
                    children: listImageRight
                        .map(
                          (e) => _buidlImageHomScreen(
                            e['name']!,
                            e['image']!,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      // implementLoading: true,
      // implementTraveling: true,
    );
  }
}
