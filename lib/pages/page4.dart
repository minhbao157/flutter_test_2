import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/color_picker_cubit.dart';
import '../widgets/multi_block_picker_widget.dart';

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  void initState() {
    super.initState();
    context.read<ColorPickerCubit>().resetColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick Multiple Colors Using Cubit')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ColorPickerCubit>().initializeDefaultColors();
                showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: context.read<ColorPickerCubit>(),
                      child: AlertDialog(
                        title: const Text('Pick Colors'),
                        content: const MultiBlockPickerCubitWidget(),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.read<ColorPickerCubit>().clearTempColors();
                            },
                            child: const Text('CLEAR'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text('CANCEL'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<ColorPickerCubit>().submitColors();
                                  context.pop();
                                },
                                child: const Text('DONE'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text('Pick Multiple Colors'),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ColorPickerCubit, ColorPickerState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: state.selectedColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        context.read<ColorPickerCubit>().toggleTempColor(color);
                      },
                      onLongPress: () {
                        context.read<ColorPickerCubit>().removeColorFromSelection(color);
                      },
                      behavior: HitTestBehavior.translucent,
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
