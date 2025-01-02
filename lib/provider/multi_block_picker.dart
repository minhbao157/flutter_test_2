// import 'package:flutter/material.dart';
// import 'color_item.dart'; // Đường dẫn tới ColorItem

// class MultiBlockPicker extends StatelessWidget {
//   final List<Color> availableColors;
//   final List<Color> selectedColors;
//   final ValueChanged<Color> onColorToggle;

//   const MultiBlockPicker({
//     Key? key,
//     required this.availableColors,
//     required this.selectedColors,
//     required this.onColorToggle,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       alignment: WrapAlignment.center,
//       spacing: 10,
//       runSpacing: 10,
//       children: availableColors.map((color) {
//         return ColorItem(
//           color: color,
//           isSelected: selectedColors.contains(color),
//           onToggle: onColorToggle,
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/color_picker_provider.dart';

class MultiBlockPicker extends StatelessWidget {
  const MultiBlockPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lấy provider ColorPickerProvider từ context
    final provider = Provider.of<ColorPickerProvider>(context);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: provider.availableColors.map((color) {
        // Kiểm tra màu có được chọn tạm thời không
        final isSelected = provider.tempSelectedColors.contains(color);
        return GestureDetector(
          onTap: () => provider.toggleTempColor(color), 
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
