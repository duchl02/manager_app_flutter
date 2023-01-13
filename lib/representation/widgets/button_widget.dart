import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/core/constants/textstyle_ext.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {Key? key, required this.title, this.ontap, required this.isCancel})
      : super(key: key);

  final String title;
  final Function()? ontap;
  bool isCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isCancel
              ? theme.primaryColor.withOpacity(0.2)
              : theme.primaryColor
          // gradient:
          //     color != null ? null : Gradients.defaultGradientBackground,
          ,
        ),
        alignment: Alignment.center,
        child: Text(title,
            style: isCancel
                ? theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)
                : theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
