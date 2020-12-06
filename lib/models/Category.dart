import 'package:flutter/cupertino.dart';
import 'package:flutter_reader/generated/l10n.dart';

class Category {
  final String name;
  final int id;
  final Color color;
  
  Category(this.name, this.id, this.color);
  
  static List<Category> allCategories() {
    return [
      Category(S.current.Science, 0, Color(0xFF4E67A8)),
      Category(S.current.Mathematics, 1, Color(0xFF68893F)),
      Category(S.current.Economy, 2, Color(0xFFAA8957)),
    ];
  }
}