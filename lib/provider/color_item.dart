import 'package:flutter/material.dart';

class ColorItem extends StatefulWidget {
  final Color color;
  final bool isSelected;
  final ValueChanged<Color> onToggle;

  const ColorItem({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onToggle,
  }) : super(key: key);

  @override
  State<ColorItem> createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.onToggle(widget.color); // Gọi callback để thông báo trạng thái
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
          if (_isSelected)
            const Icon(
              Icons.check,
              color: Colors.white,
              size: 30,
            ),
        ],
      ),
    );
  }
}
