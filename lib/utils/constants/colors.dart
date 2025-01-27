import 'package:flutter/material.dart';

class CColors {
  CColors._();

  //app basic colors
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.yellow;
  static const Color accent = Color.fromARGB(255, 89, 211, 195);

  //gradient colors
  static const Gradient contohGradien = LinearGradient(
    begin: Alignment(0, 0),
    end: Alignment(1, -1),
    colors: [
      Color.fromARGB(255, 114, 114, 189),
      Colors.blue,
      Color.fromARGB(255, 0, 0, 88)
    ],
  );

  //text colors
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;
  static const Color textWhite = Colors.white;

  //background colors
  static const Color light = Colors.white;
  static const Color dark = Color.fromARGB(255, 28, 28, 37);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  //background container colors
  static const Color lightContainer = Colors.white;
  static Color darkContainer = CColors.textWhite.withOpacity(0.1);

  //button colors
  static const Color buttonPrimary = Colors.blue;
  static const Color buttonSeconary = Colors.grey;
  static const Color buttonDisabled = Colors.white;

  //border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  //error and validation colors
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  static const Color info = Colors.blue;

  //neutral shades
  static const Color black = Colors.black;
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Colors.grey;
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Colors.white;
}
