import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/constants/textstyle_ext.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.title, this.ontap, this.opacity})
      : super(key: key);

  final String title;
  final Function()? ontap;
  final Color? opacity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient:
              opacity != null ? null : Gradients.defaultGradientBackground,
          color: opacity,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyles.defaultStyle.bold.copyWith(
              color:
                  opacity != null ? ColorPalette.primaryColor : Colors.white),
        ),
      ),
    );
  }
}
