import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/color_picker_cubit.dart';

class MultiBlockPickerCubitWidget extends StatelessWidget {
  const MultiBlockPickerCubitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorPickerCubit, ColorPickerState>(
      builder: (context, state) {
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: state.availableColors.map((color) {
            final isSelected = state.tempSelectedColors.contains(color);
            return GestureDetector(
              onTap: () {
                context.read<ColorPickerCubit>().toggleTempColor(color);
              },
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
      },
    );
  }
}
