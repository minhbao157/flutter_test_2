import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  // Lưu trữ các màu sắc đã chọn
  List<Color> selectedColors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 3')),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: MultipleChoiceBlockPicker(
                          pickerColors: [Colors.red, Colors.yellow, Colors.green],
                          onColorsChanged: (List<Color> colors) {
                            setState(() {
                              selectedColors = colors;
                            });
                          },
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('DONE'),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Multiple Choice Color Picker"),
            ),
            const SizedBox(height: 20),
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
                    radius: 30,
                    backgroundColor: color,
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
