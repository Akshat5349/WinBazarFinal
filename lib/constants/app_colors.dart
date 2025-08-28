import 'package:flutter/material.dart';

class AppColors {
  //For appbar Material Color
  static const Map<int, Color> colorCustom = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  static const goldGradient = LinearGradient(
    colors: [
      Color(0xFFEBD197), // Light gold
      Color(0xFFB48811), // Rich gold
      Color(0xFFA2790D), // Deep gold
      Color(0xFFBB9B49), // Muted gold highlight
    ],
    stops: [0.0, 0.5, 0.7, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const primaryColor = Color(0xFF020b1c);
  static const primaryAccentColor = Color(0xFF020b1c);
  static const primaryColorback = Color(0xFF020b1c);
  static const lightYellow = Color(0xFFfffeac);
  static const bgGrey = Color(0xFFF9F9FB);
  static const lightGrey = Color(0xFFF9F9FB);
  static const grey = Color(0xFF758594);
  static const darkGrey = Color(0xFF5A5D61);
  static const walletPriceGrey = Color(0xFF788A9B);
  static const blackColor = Color(0xFF4A4F55);
  static const whiteColor = Color(0xFFFFFFFF);
  static const pinkColor = Color(0xFF03045e);
  static const blueColor = Color(0xFF2a000c);
  static const goldColor = Color(0xFFE1B941);
  // static const pinkColor = Color(0xFFd906c3);
  // static const blueColor = Color(0xFF3c309b);
}
