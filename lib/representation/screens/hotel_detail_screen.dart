import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Data/models/hotel_modal.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/representation/screens/room_screen.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';

import '../../core/constants/textstyle_ext.dart';
import '../widgets/dash_line.dart';

class HotelScreenDetail extends StatefulWidget {
  const HotelScreenDetail({super.key, required this.hotelModel});

  static const String routeName = "/hotel_detail";

  final HotelModel hotelModel;

  @override
  State<HotelScreenDetail> createState() => _HotelScreenDetailState();
}

class _HotelScreenDetailState extends State<HotelScreenDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: ImageHelper.loadFromAsset(AssetHelper.hotelScreen,
                  fit: BoxFit.fill)),
          Positioned(
              top: kMediumPadding * 3,
              left: kMediumPadding,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  // height: 30,
                  // width: 30,
                  padding: EdgeInsets.all(kItemPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(kItemPadding))),
                  child: Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 18,
                  ),
                ),
              )),
          Positioned(
              top: kMediumPadding * 3,
              right: kMediumPadding,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  // height: 30,
                  // width: 30,
                  padding: EdgeInsets.all(kItemPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(kItemPadding))),
                  child: Icon(
                    FontAwesomeIcons.solidHeart,
                    size: 18,
                    color: Colors.red,
                  ),
                ),
              )),
          DraggableScrollableSheet(
              initialChildSize: 0.1,
              maxChildSize: 0.8,
              minChildSize: 0.1,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(kDefaultPadding * 2),
                          topRight: Radius.circular(kDefaultPadding * 2))),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: kDefaultPadding / 2),
                        child: Container(
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(kItemPadding))),
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Expanded(
                          child: ListView(
                        controller: scrollController,
                        children: [
                          Text(
                            widget.hotelModel.hotelName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '\$${widget.hotelModel.price.toString()}',
                            style: TextStyles.defaultStyle.fontHeader.bold,
                          ),
                          Text(
                            ' /night',
                            style: TextStyles.defaultStyle.fontCaption,
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            children: [
                              ImageHelper.loadFromAsset(
                                AssetHelper.icoLocationBlank,
                              ),
                              SizedBox(
                                width: kMinPadding,
                              ),
                              Text(
                                widget.hotelModel.location,
                              ),
                              Text(
                                ' - ${widget.hotelModel.awayKilometer} from destination',
                                style: TextStyles
                                    .defaultStyle.subTitleTextColor.fontCaption,
                              ),
                            ],
                          ),
                          DashLineWidget(),
                          Row(
                            children: [
                              ImageHelper.loadFromAsset(
                                AssetHelper.icoStar,
                              ),
                              SizedBox(
                                width: kMinPadding,
                              ),
                              Text(
                                widget.hotelModel.star.toString(),
                              ),
                              Text(
                                ' (${widget.hotelModel.numberOfReview} reviews)',
                                style:
                                    TextStyles.defaultStyle.subTitleTextColor,
                              ),
                              Spacer(),
                              Text(
                                'See All',
                                style: TextStyles
                                    .defaultStyle.bold.primaryTextColor,
                              ),
                            ],
                          ),
                          DashLineWidget(),
                          Text(
                            'Information',
                            style: TextStyles.defaultStyle.bold,
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Text(
                            '''You will find every comfort because many of the services that the hotel offers for travellers and of course the hotel is very comfortable.''',
                          ),
                          // ItemUtilityHotelWidget(),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Text(
                            'Location',
                            style: TextStyles.defaultStyle.bold,
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Text(
                            '''Located in the famous neighborhood of Seoul, Grand Luxury’s is set in a building built in the 2010s.''',
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          ImageHelper.loadFromAsset(
                            AssetHelper.imageMap,
                            width: double.infinity,
                          ),
                          SizedBox(
                            height: kMediumPadding,
                          ),
                          ButtonWidget(
                              title: 'Select Room',
                              ontap: () {
                                Navigator.of(context)
                                    .pushNamed(RoomScreen.routeName);
                              }),
                          SizedBox(
                            height: kMediumPadding,
                          ),
                        ],
                      ))
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
