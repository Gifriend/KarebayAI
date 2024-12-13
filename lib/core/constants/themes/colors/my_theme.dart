import 'package:flutter/material.dart';
import 'package:karebay/core/constants/themes/colors/pallete.dart';

// light theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    background: Pallete.paleGray,
    onBackground: Pallete.paleGray,
    seedColor: Pallete.deepOceanBlue,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

// dark theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Pallete.deepOceanBlue,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);
