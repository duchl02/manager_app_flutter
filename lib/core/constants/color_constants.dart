import 'package:flutter/material.dart';

class ColorPalette {
  static const Color primaryColor = Color.fromARGB(255, 34, 40, 49);
  static const Color secondColor = Color.fromARGB(255, 57, 62, 70);
  static const Color yellowColor = Color.fromARGB(255, 255, 153, 102);

  static const Color textWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color text1Color = Color.fromARGB(255, 0, 173, 181);
  static const Color subTitleColor = Color(0xFF838383);
  static const Color backgroundScaffoldColor = Color.fromARGB(255, 238, 238, 238);
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