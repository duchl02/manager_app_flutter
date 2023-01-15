import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';

class FormInputField extends StatelessWidget {
  const FormInputField(
      {Key? key,
      required this.label,
      required this.hintText,
      this.controller,
      this.focusNode,
      this.onChanged,
      this.maxLines = 1,
      this.onTap,
      this.validator,
      this.obscureText = false,
      this.inputType = TextInputType.text})
      : super(key: key);

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int maxLines;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            maxLines: maxLines,
            // style: TextStyleCustom.normalSizeBlack,
            controller: controller,
            focusNode: focusNode,
            keyboardType: inputType,
            obscureText: obscureText,
            onTap: onTap,
            readOnly: onTap != null,
            validator: validator,
            decoration: InputDecoration(
              labelText: hintText,
              // fillColor: ColorPalette.secondColor,
              // labelStyle: theme.textTheme.subtitle1,
              suffixIcon: onTap != null
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ],
      ),
    );
  }
}
