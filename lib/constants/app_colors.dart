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

  // Modern colorful gradients for CTAs
  static const primaryGradient = LinearGradient(
    colors: [
      Color(0xFF4FC3F7), // Light blue
      Color(0xFF29B6F6), // Medium blue
      Color(0xFF0288D1), // Darker blue
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const successGradient = LinearGradient(
    colors: [
      Color(0xFF66BB6A), // Light green
      Color(0xFF4CAF50), // Green
      Color(0xFF388E3C), // Dark green
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const warningGradient = LinearGradient(
    colors: [
      Color(0xFFFFB74D), // Light orange
      Color(0xFFFF9800), // Orange
      Color(0xFFF57C00), // Dark orange
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const errorGradient = LinearGradient(
    colors: [
      Color(0xFFEF5350), // Light red
      Color(0xFFF44336), // Red
      Color(0xFFD32F2F), // Dark red
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Modern color palette
  static const primaryColor = Color(0xFF42A5F5); // Light blue
  static const primaryAccentColor = Color(0xFF42A5F5); // Light blue
  static const primaryColorback = Color(0xFFFFFFFF); // White background
  static const lightBlue = Color(0xFFE3F2FD); // Very light blue
  static const bgGrey = Color(0xFFFAFAFA); // Light grey background
  static const lightGrey = Color(0xFFE0E0E0); // Light grey
  static const grey = Color(0xFF9E9E9E); // Medium grey
  static const darkGrey = Color(0xFF424242); // Dark grey
  static const walletPriceGrey = Color(0xFF616161); // Wallet text color
  static const blackColor = Color(0xFF212121); // Almost black
  static const whiteColor = Color(0xFFFFFFFF); // Pure white
  static const pinkColor = Color(0xFFE91E63); // Pink accent
  static const blueColor = Color(0xFF2196F3); // Blue accent
  static const goldColor = Color(0xFFFFC107); // Gold/Yellow accent

  // Additional modern colors
  static const successColor = Color(0xFF4CAF50); // Green
  static const warningColor = Color(0xFFFF9800); // Orange
  static const errorColor = Color(0xFFF44336); // Red
  static const infoColor = Color(0xFF2196F3); // Blue

  // Card and surface colors
  static const cardColor = Color(0xFFFFFFFF); // White cards
  static const surfaceColor = Color(0xFFFAFAFA); // Surface background
  static const dividerColor = Color(0xFFE0E0E0); // Dividers
  // static const pinkColor = Color(0xFFd906c3);
  // static const blueColor = Color(0xFF3c309b);
}
