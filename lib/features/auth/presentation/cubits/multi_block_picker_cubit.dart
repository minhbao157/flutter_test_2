//Flutter Core packages
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MultiBlockPickerState extends Equatable {
  final List<Color> selectedColors;

  const MultiBlockPickerState({this.selectedColors = const []});

  MultiBlockPickerState copyWith({List<Color>? selectedColors}) {
    return MultiBlockPickerState(
      selectedColors: selectedColors ?? this.selectedColors,
    );
  }

  @override
  List<Object> get props => [selectedColors];
}

class MultiBlockPickerCubit extends Cubit<MultiBlockPickerState> {
  MultiBlockPickerCubit() : super(const MultiBlockPickerState());

  void toggleColorSelection(Color color) {
    final updatedColors = List<Color>.from(state.selectedColors);
    if (updatedColors.contains(color)) {
      updatedColors.remove(color);
    } else {
      updatedColors.add(color);
    }
    emit(state.copyWith(selectedColors: updatedColors));
  }

  void clearSelection() {
    emit(const MultiBlockPickerState());
  }
}
