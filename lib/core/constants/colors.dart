import 'package:flutter/material.dart';

sealed class AppColors {
  static const Color primary = Color(0xFF343FDE);
  static const Color yellow = Color(0xFFFFC71E);
  static const Color surface = Color(0xFFEDEEFC);
  static const Color green = Color(0xFFA2E052);
  static const Color grey = Color(0xFF96969C);
  static const Color darkGrey = Color(0xFF57575C);
  static const Color lightGrey = Color(0xFFE5E5E6);
}

class CustomColors {
  static const Color primaryColor = Color(0xFF343FDE);

  // Create a MaterialColor using the primary color
  static MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: _createShade(0.1),
      100: _createShade(0.2),
      200: _createShade(0.3),
      300: _createShade(0.4),
      400: _createShade(0.5),
      500: primaryColor,
      600: _createShade(0.7),
      700: _createShade(0.8),
      800: _createShade(0.9),
      900: _createShade(1.0),
    },
  );

  static const int _primaryValue = 0xFF343FDE;

  // Create a shade of the primary color
  static Color _createShade(double strength) {
    final double t = strength;
    final int r = ((1 - t) * 255 + t * 52).toInt();
    final int g = ((1 - t) * 255 + t * 63).toInt();
    final int b = ((1 - t) * 255 + t * 222).toInt();
    return Color.fromARGB(255, r, g, b);
  }
}
