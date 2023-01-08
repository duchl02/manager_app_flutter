import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/text_style.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({
    Key? key,
    required this.label,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.maxLines = 1,
    this.onTap,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int maxLines;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: TextStyleCustom.normalSizePrimary),
          SizedBox(
            height: 6,
          ),
          TextFormField(
            maxLines: maxLines,
            style: TextStyleCustom.normalSizeBlack,
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            onTap: onTap,
            readOnly: onTap != null,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: ColorPalette.secondColor,
              hintStyle:
                  TextStyle(color: ColorPalette.primaryColor.withOpacity(0.5)),
              suffixIcon: onTap != null
                  ? const Icon(Icons.keyboard_arrow_down,
                      color: ColorPalette.secondColor)
                  : null,
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorPalette.text1Color, width: 2.0),
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
