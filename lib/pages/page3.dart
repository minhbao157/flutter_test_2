import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../provider/multi_block_picker.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final List<Color> availableColors = [
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

  // Biến này sẽ chứa các màu được chọn trong suốt phiên làm việc
  List<Color> selectedColors = [];

  // Biến này để lưu tạm thời màu sắc đã chọn trong dialog
  List<Color> tempSelectedColors = [];

  @override
  void initState() {
    super.initState();
    selectedColors = []; // Khởi tạo mảng màu sắc trống
    tempSelectedColors = []; // Khởi tạo mảng màu sắc tạm thời
  }

  // Hàm để cập nhật màu sắc
  void _updateSelectedColors(List<Color> newSelectedColors) {
    setState(() {
      selectedColors = newSelectedColors;
    });
  }

  // Hàm để xóa tất cả màu đã chọn trong dialog
  void _clearTempSelectedColors() {
    setState(() {
      tempSelectedColors.clear();
    });
  }

  // Hàm để đồng bộ màu sắc trong tempSelectedColors với selectedColors
  void _toggleColorInDialog(Color color) {
    setState(() {
      if (tempSelectedColors.contains(color)) {
        tempSelectedColors.remove(color);
      } else {
        tempSelectedColors.add(color);
      }
      print('Current tempSelectedColors: $tempSelectedColors');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 3')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tempSelectedColors = List.from(selectedColors);
                  if (tempSelectedColors.isEmpty) {
                    tempSelectedColors.addAll([Colors.red, Colors.yellow, Colors.green]);
                  }  
                });
                
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick multiple colors!'),
                      content: MultiBlockPicker(
                        availableColors: availableColors,
                        selectedColors: tempSelectedColors,  // Truyền selectedColors vào đây
                        onColorToggle: _toggleColorInDialog, // Cập nhật trạng thái màu trong dialog
                      ),
                      actions: [
                        // Nút "Clear" nằm bên trái
                        TextButton(
                          onPressed: _clearTempSelectedColors, // Xóa tất cả màu đã chọn trong dialog
                          child: const Text('CLEAR'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Nút "Cancel" để hủy bỏ
                            TextButton(
                              onPressed: () {
                                context.pop(); // Đóng hộp thoại mà không lưu
                              },
                              child: const Text('CANCEL'),
                            ),
                            // Nút "Done" để xác nhận
                            TextButton(
                              onPressed: () {
                                _updateSelectedColors(tempSelectedColors); // Lưu lựa chọn
                                context.pop(); // Đóng hộp thoại
                              },
                              child: const Text('DONE'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Pick Multiple Colors"),
            ),
            const SizedBox(height: 20),
            // Hiển thị các màu đã chọn
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: selectedColors.map((color) {
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      selectedColors.remove(color);
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 30,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
