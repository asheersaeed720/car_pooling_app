import 'package:car_pooling_app/utils/colors.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF082d4a);

//* Light Theme
const secondaryColorLightTheme = Color(0xFFEEF1F7);
const textColorLightTheme = Color(0xFF132144);

//* Dart Theme
const secondaryColorDarkTheme = Color(0xFF242339);
const textColorDarkTheme = Color(0xFF19182C);
const kPrimaryDarkColor = Color(0xff46BDFA);
const kBackgroundColor = Color(0xffEFF2F7);

const defaultPadding = 14.0;
const fontName = 'Poppins';

TextTheme textTheme = const TextTheme(
  headline1: TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 22.0,
  ),
  bodyText1: TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  ),
);

TextStyle kTitleStyle = TextStyle(
  color: Color(MyColors.header01),
  fontWeight: FontWeight.bold,
);

TextStyle kFilterStyle = TextStyle(
  color: Color(MyColors.bg02),
  fontWeight: FontWeight.w500,
);
