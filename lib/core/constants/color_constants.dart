import 'package:flutter/material.dart';

class ColorPalette {
  static const Color primaryColor = Color(0xff6155CC);
  static const Color secondColor = Color(0xff8F67E8);
  static const Color yellowColor = Color(0xffFE9C5E);

  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color text1Color = Colors.purple;
  static const Color subTitleColor = Color(0xFF838383);
  static const Color backgroundScaffoldColor = Color(0xFFF2F2F2);

  static const Color textWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color text1Black = Color.fromARGB(255, 0, 0, 0);

}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      ColorPalette.secondColor,
      ColorPalette.primaryColor,
    ],
  );
}
