//Flutter Core Packages
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ColorPickerState extends Equatable {
  final List<Color> availableColors;
  final List<Color> selectedColors;
  final List<Color> tempSelectedColors;

  const ColorPickerState({
    this.availableColors = const [
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
    ],
    this.selectedColors = const [],
    this.tempSelectedColors = const [],
  });

  ColorPickerState copyWith({
    List<Color>? availableColors,
    List<Color>? selectedColors,
    List<Color>? tempSelectedColors,
  }) {
    return ColorPickerState(
      availableColors: availableColors ?? this.availableColors,
      selectedColors: selectedColors ?? this.selectedColors,
      tempSelectedColors: tempSelectedColors ?? this.tempSelectedColors,
    );
  }

  @override
  List<Object> get props => [availableColors, selectedColors, tempSelectedColors];
}

class ColorPickerCubit extends Cubit<ColorPickerState> {
  ColorPickerCubit() : super(const ColorPickerState());

  void initializeDefaultColors() {
    emit(state.copyWith(
      tempSelectedColors: state.selectedColors.isNotEmpty
          ? List.from(state.selectedColors)
          : [Colors.red, Colors.yellow, Colors.green],
    ));
  }

  void toggleTempColor(Color color) {
    final updatedTempColors = List<Color>.from(state.tempSelectedColors);
    if (updatedTempColors.contains(color)) {
      updatedTempColors.remove(color);
    } else {
      updatedTempColors.add(color);
    }
    emit(state.copyWith(tempSelectedColors: updatedTempColors));
  }

  void submitColors() {
    emit(state.copyWith(selectedColors: List.from(state.tempSelectedColors)));
  }

  void clearTempColors() {
    emit(state.copyWith(tempSelectedColors: []));
  }

  void resetColors() {
    emit(const ColorPickerState());
  }

  bool isColorSelected(Color color) {
    return state.tempSelectedColors.contains(color);
  }

  void removeColorFromSelection(Color color) {
    if (state.selectedColors.contains(color)) {
      final updatedSelection = List<Color>.from(state.selectedColors)..remove(color);
      emit(state.copyWith(selectedColors: updatedSelection));
    }
  }

  void addColorToSelection(Color color) {
    if (!state.selectedColors.contains(color)) {
      final updatedSelection = List<Color>.from(state.selectedColors)..add(color);
      emit(state.copyWith(selectedColors: updatedSelection));
    }
  }
}
