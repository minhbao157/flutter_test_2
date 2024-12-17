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

  // Thêm phương thức clearColors() để xóa tất cả màu đã chọn
  void clearColors() {
    selectedColors.clear();
    notifyListeners();
  }
}

