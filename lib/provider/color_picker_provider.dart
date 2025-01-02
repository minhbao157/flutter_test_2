import 'package:flutter/material.dart';

class ColorPickerProvider extends ChangeNotifier {
  final List<Color> _availableColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

  List<Color> _selectedColors = [];
  List<Color> _tempSelectedColors = [];

  List<Color> get availableColors => _availableColors;
  List<Color> get selectedColors => _selectedColors;
  List<Color> get tempSelectedColors => _tempSelectedColors;

  void initializeDefaultColors() {
    _tempSelectedColors = selectedColors.isNotEmpty
        ? List.from(selectedColors)
        : [Colors.red, Colors.yellow, Colors.green];
    notifyListeners();
  }

  void toggleTempColor(Color color) {
    if (_tempSelectedColors.contains(color)) {
      _tempSelectedColors.remove(color);
    } else {
      _tempSelectedColors.add(color);
    }
    notifyListeners();
  }

  void submitColors() {
    _selectedColors = List.from(_tempSelectedColors);
    notifyListeners();
  }

  void clearTempColors() {
    _tempSelectedColors.clear();
    notifyListeners();
  }

  void resetColors() {
    _selectedColors.clear();
    _tempSelectedColors.clear();
    notifyListeners();
  }
}
