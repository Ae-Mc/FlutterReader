import 'package:flutter/cupertino.dart';

class News {
  final String hintText;
  final String headerFirstLine;
  final String headerSecondLine;
  final String imageUrl;
  final Color backgroundColor;

  News(
    this.hintText,
    this.headerFirstLine,
    this.headerSecondLine,
    this.imageUrl,
    this.backgroundColor,
  );
}
