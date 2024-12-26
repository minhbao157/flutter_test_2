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

  // Khởi tạo màu mặc định trong dialog
  void initializeDefaultColors() {
    _tempSelectedColors = selectedColors.isNotEmpty
        ? List.from(selectedColors)
        : [Colors.red, Colors.yellow, Colors.green];
    notifyListeners();
  }

  // Thêm hoặc xóa màu trong danh sách tạm thời
  void toggleTempColor(Color color) {
    if (tempSelectedColors.contains(color)) {
      tempSelectedColors.remove(color);
    } else {
      tempSelectedColors.add(color);
    }
    notifyListeners();
  }

  // Đồng bộ danh sách chính thức với danh sách tạm thời
  void submitColors() {
    _selectedColors = List.from(tempSelectedColors);
    notifyListeners();
  }

  // Xóa tất cả màu trong danh sách tạm thời
  void clearTempColors() {
    tempSelectedColors.clear();
    notifyListeners();
  }

  void resetColors() {
    _selectedColors.clear(); // Xóa danh sách màu chính thức
    _tempSelectedColors.clear(); // Xóa danh sách màu tạm thời
    notifyListeners();
  }
}
