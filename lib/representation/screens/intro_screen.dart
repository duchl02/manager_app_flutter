import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/helpers/asset_helper.dart';
import 'package:travel_app/core/helpers/image_helper.dart';
import 'package:travel_app/core/constants/textstyle_ext.dart';
import 'package:travel_app/representation/screens/main_app.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const routeName = 'intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  final StreamController<int> _pageStreamController =
      StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _pageStreamController.add(_pageController.page!.toInt());
    });
  }

  Widget _buildItemIntroScreen(String image, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: ImageHelper.loadFromAsset(
            image,
            height: 500,
            fit: BoxFit.fitHeight,
          ),
        ),
        const SizedBox(
          height: kMediumPadding * 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kMediumPadding,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyles.defaultStyle.bold,
            ),
            const SizedBox(
              height: kMediumPadding,
            ),
            Text(
              description,
              style: TextStyles.defaultStyle,
            )
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildItemIntroScreen(
                  AssetHelper.slide1, "item1", "description 1"),
              _buildItemIntroScreen(
                  AssetHelper.slide2, "item2", "description 2"),
              _buildItemIntroScreen(
                  AssetHelper.slide3, "item3", "description 3"),
            ],
          ),
          Positioned(
              left: kMediumPadding,
              right: kMediumPadding,
              bottom: kMediumPadding * 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.orange,
                          dotWidth: kMinPadding,
                          dotHeight: kMinPadding),
                    ),
                  ),
                  StreamBuilder<int>(
                      initialData: 0,
                      stream: _pageStreamController.stream,
                      builder: (context, snapshot) {
                        return Expanded(
                            flex: 4,
                            child: ButtonWidget(
                              title:
                                  snapshot.data != 2 ? "Next" : "Get started",
                              ontap: () {
                                if (_pageController.page != 2) {
                                  _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.linear);
                                } else {
                                  Navigator.of(context)
                                      .pushNamed(MainApp.routeName);
                                }
                              },
                            ));
                      })
                ],
              ))
        ],
      ),
    );
  }
}
