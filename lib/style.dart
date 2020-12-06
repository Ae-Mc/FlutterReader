import 'package:flutter/material.dart';

final primaryColor = Colors.black;
final accentColor = Color(0xFF878CAE);
final buttonColor = Color(0xFFFF5F54);
final shadowColor = Color(0xFFD6D5DC);
final backgroundColor = Colors.white;
final scrollProgressBarColor = Color(0xFFD4D3D9);
Color readerBackgroundColor = Colors.white;
Color readerTextColor = Colors.black;

final myTextTheme = TextTheme(
  bodyText1: TextStyle(color: accentColor, fontSize: 16),
  bodyText2: TextStyle(color: primaryColor, fontSize: 10),
  subtitle1:
      TextStyle(color: primaryColor, fontWeight: FontWeight.w200, fontSize: 14),
  subtitle2:
      TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.w500),
  headline3:
      TextStyle(color: primaryColor, fontSize: 40, fontWeight: FontWeight.w700),
  headline4: TextStyle(color: primaryColor, fontSize: 30),
  headline5:
      TextStyle(color: primaryColor, fontSize: 24, fontWeight: FontWeight.w700),
  headline6: TextStyle(
      color: Color(0xFF580600), fontWeight: FontWeight.w700, fontSize: 16),
);
final signInInputFieldsStyle = TextStyle(color: primaryColor, fontSize: 16);
final signInLogInButtonTextStyle = TextStyle(
  color: backgroundColor,
  fontSize: 20,
  fontWeight: FontWeight.w700,
);
final signInErrorTextStyle = TextStyle(
  color: Colors.red[900],
  fontSize: 12
);

Map<String, dynamic> chapterText = {
  'style': TextStyle(
      fontSize: 14,
      fontFamily: "Barlow",
      fontWeight: FontWeight.w400,
      color: readerTextColor),
  'align': TextAlign.justify
};

TextStyle chapterTitleText = TextStyle(fontWeight: FontWeight.w500);
