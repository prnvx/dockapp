import 'package:flutter/material.dart';
import 'dart:math';

import '../model/dockitem.dart';

class DockViewModel extends ChangeNotifier {
  List<DockItem> _items = [];

  List<DockItem> get items => _items;

  void initializeItems(List<IconData> icons) {
    _items = icons.map((icon) {
      return DockItem(
        icon: icon,
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      );
    }).toList();
    notifyListeners();
  }

  void reorderItems(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);
    notifyListeners();
  }
}
