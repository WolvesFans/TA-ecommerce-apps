import 'package:flutter/material.dart';
import 'package:comro_alt/utils/theme/custom_theme/text_theme.dart';
import 'package:comro_alt/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:comro_alt/utils/theme/custom_theme/appbar_theme.dart';
import 'package:comro_alt/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:comro_alt/utils/theme/custom_theme/checkbox_theme.dart';
import 'package:comro_alt/utils/theme/custom_theme/chip_theme.dart';
import 'package:comro_alt/utils/theme/custom_theme/outlined_button_theme.dart';
import 'package:comro_alt/utils/theme/custom_theme/text_form_field_theme.dart';

class CAppTheme {
  //private constructor
  CAppTheme._();

  //light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: CAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: CBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: CChekboxTheme.lightCheckboxTheme,
    chipTheme: CChipTheme.lightChipTheme,
    elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: COutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.lightInputDecorationTheme,
    textTheme: CTextTheme.lightTextTheme,
  );

  //dark theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: CAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: CBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: CChekboxTheme.darkCheckboxTheme,
    chipTheme: CChipTheme.darkChipTheme,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: COutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.darkInputDecorationTheme,
    textTheme: CTextTheme.darkTextTheme,
  );
}
