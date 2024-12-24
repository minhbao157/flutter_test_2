import 'package:flutter/material.dart';
import 'color_item.dart'; // Đường dẫn tới ColorItem

class MultiBlockPicker extends StatelessWidget {
  final List<Color> availableColors;
  final List<Color> selectedColors;
  final ValueChanged<Color> onColorToggle;

  const MultiBlockPicker({
    Key? key,
    required this.availableColors,
    required this.selectedColors,
    required this.onColorToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: availableColors.map((color) {
        return ColorItem(
          color: color,
          isSelected: selectedColors.contains(color),
          onToggle: onColorToggle,
        );
      }).toList(),
    );
  }
}
