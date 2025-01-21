//Flutter Core Packages
import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  List<Color> selectedColors = [];

  void toggleColor(Color color) {
    if (selectedColors.contains(color)) {
      selectedColors.remove(color);
    } else {
      selectedColors.add(color);
    }
    notifyListeners();
  }

  void removeColor(Color color) {
    selectedColors.remove(color);
    notifyListeners();
  }

  void setSelectedColors(List<Color> colors) {
    selectedColors = colors;
    notifyListeners();
  }

  void clearColors() {
    selectedColors.clear();
    notifyListeners();
  }
}