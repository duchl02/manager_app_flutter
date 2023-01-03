import 'package:flutter/material.dart';

import 'color_constants.dart';

class TextStyleCustom {
  static const TextStyle nomalTextPrimary = TextStyle(
      color: ColorPalette.text1Color,
      fontWeight: FontWeight.bold,
      fontSize: 14);

  static const TextStyle nomalTextWhile =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);
  static const TextStyle h1Text =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26);
  static const TextStyle h2Text =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
  static const TextStyle h2TextPrimary = TextStyle(
      color: ColorPalette.text1Color,
      fontWeight: FontWeight.bold,
      fontSize: 20);
  static TextStyle smallText = TextStyle(
    color: Colors.blueGrey.shade900,
  ); static TextStyle normalText = TextStyle(
    color: Colors.blueGrey.shade900,fontSize: 18,
  );
  static TextStyle normalSize = TextStyle(fontSize: 18, color: Colors.white);
  static TextStyle normalSizeBlack = TextStyle(fontSize: 18, color: Colors.black);
  static TextStyle normalSizePrimary =
      TextStyle(fontSize: 18, color: ColorPalette.primaryColor);
}
