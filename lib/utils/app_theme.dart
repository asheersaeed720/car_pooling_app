import 'package:car_pooling_app/utils/constants.dart';
import 'package:flutter/material.dart';

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color(0xFFECF3F9),
  errorColor: Colors.red[800],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
  // textTheme: textTheme,
);

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color(0xFFECF3F9),
  errorColor: Colors.red[800],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
  // textTheme: textTheme,
);
