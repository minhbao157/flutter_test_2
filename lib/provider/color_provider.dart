import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  // Danh sách các màu được chọn
  List<Color> selectedColors = [];

  // Thêm hoặc bỏ chọn màu trong danh sách
  void toggleColor(Color color) {
    if (selectedColors.contains(color)) {
      selectedColors.remove(color);
    } else {
      selectedColors.add(color);
    }
    notifyListeners();
  }

  // Xoá một màu khỏi danh sách
  void removeColor(Color color) {
    selectedColors.remove(color);
    notifyListeners();
  }

  // Cập nhật lại danh sách màu đã chọn (bao gồm thêm các màu mặc định)
  void setSelectedColors(List<Color> colors) {
    selectedColors = colors;
    notifyListeners();
  }

  // Xoá tất cả các màu đã chọn
  void clearColors() {
    selectedColors.clear();
    notifyListeners();
  }

  
}