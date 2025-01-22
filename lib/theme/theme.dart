import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
    surface: Colors.grey.shade900,
  ),
);


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    surface: Colors.grey.shade100,
  ),
);
