import 'package:flutter/material.dart';

class ColorTheme {
  final String name;
  final Color textColor;
  final Color backgroundColor;

  const ColorTheme(this.name, this.textColor, this.backgroundColor);
}

class ReaderState with ChangeNotifier {
  int _fontSize = 0;
  int _fontFamily = 0;
  int _theme = 0;
  double offset = 0;

  ColorTheme get theme => Themes[_theme];
  String get fontFamily => FontFamilies[_fontFamily];
  int get fontSize => FontSizes[_fontSize];
  double get headerSize => (FontSizes[_fontSize] * 2.5);

  set theme(ColorTheme theme) {
    _theme = _setter(theme, Themes, _theme);
    notifyListeners();
  }

  set fontFamily(String fontFamily) {
    _fontFamily = _setter(fontFamily, FontFamilies, _fontFamily);
    notifyListeners();
  }

  set fontSize(int size) {
    _fontSize = _setter(size, FontSizes, _fontSize);
    notifyListeners();
  }

  static const List<ColorTheme> Themes = [
    ColorTheme("White", Colors.black, Colors.white),
    ColorTheme("Black", Colors.white, Colors.black87),
    ColorTheme("Sepia", Colors.black,
        Color(0xFFFFE082)), // Color is Colors.amberAccent[200]
  ];

  static const List<String> FontFamilies = [
    "Arial",
    "Barlow",
    "Times New Roman",
  ];

  static const List<int> FontSizes = [
    8,
    16,
    24,
    32,
  ];

  int _setter(dynamic value, List<dynamic> valuesList, int defaultIndex) {
    int index = valuesList.indexOf(value);
    if (index == -1) return defaultIndex;
    return index;
  }
}
