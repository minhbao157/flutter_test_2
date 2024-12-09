import 'package:flutter/material.dart';

class ColorState with ChangeNotifier {
  Color _selectedColor = Colors.white;  
  List<Color> _selectedColors = [];     

  Color get selectedColor => _selectedColor;
  List<Color> get selectedColors => _selectedColors;

  void updateSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();  
  }

  void addSelectedColor(Color color) {
    _selectedColors.add(color);
    notifyListeners(); 
  }

  void removeSelectedColor(Color color) {
    _selectedColors.remove(color);
    notifyListeners();  
  }
}
