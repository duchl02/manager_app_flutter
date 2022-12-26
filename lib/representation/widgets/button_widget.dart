import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/constants/textstyle_ext.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.title, this.ontap, this.color})
      : super(key: key);

  final String title;
  final Function()? ontap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient:
              color != null ? null : Gradients.defaultGradientBackground,
          color: color,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyles.defaultStyle.bold.copyWith(
              color:
                  color != null ? ColorPalette.primaryColor : Colors.white  ),
        ),
      ),
    );
  }
}
