import 'package:flutter/material.dart';

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
        final isSelected = selectedColors.contains(color);
        return GestureDetector(
          onTap: () => onColorToggle(color),
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
                  color: Colors.black,
                  size: 30,
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
