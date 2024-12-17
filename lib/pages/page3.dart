import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/color_provider.dart';
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

  @override
  void initState() {
    super.initState();
    // Reset lại màu đã chọn trong ColorProvider khi trang được tạo lại
    Provider.of<ColorProvider>(context, listen: false).clearColors();
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick multiple colors!'),
                      content: Consumer<ColorProvider>(
                        builder: (context, colorProvider, child) {
                          return MultiBlockPicker(
                            availableColors: availableColors,
                            selectedColors: colorProvider.selectedColors,
                            onColorToggle: (color) {
                              colorProvider.toggleColor(color);
                            },
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text('DONE'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Pick Multiple Colors"),
            ),
            const SizedBox(height: 20),
            Consumer<ColorProvider>(
              builder: (context, colorProvider, child) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: colorProvider.selectedColors.map((color) {
                    return GestureDetector(
                      onLongPress: () => colorProvider.removeColor(color),
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 30,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
