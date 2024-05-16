part of 'color_bloc.dart';

class ColorState {
  final double redSliderValue;
  final double greenSliderValue;
  final double blueSliderValue;
  final double opacitySliderValue;

  ColorState(
      {required this.redSliderValue,
      required this.greenSliderValue,
      required this.blueSliderValue,
      required this.opacitySliderValue});

  factory ColorState.initial() => ColorState(
      redSliderValue: 0,
      greenSliderValue: 0,
      blueSliderValue: 0,
      opacitySliderValue: 0);

  ColorState copyWith(
          {double? redSliderValue,
          double? greenSliderValue,
          double? blueSliderValue,
          double? opacitySliderValue}) =>
      ColorState(
          redSliderValue: redSliderValue ?? this.redSliderValue,
          greenSliderValue: greenSliderValue ?? this.greenSliderValue,
          blueSliderValue: blueSliderValue ?? this.blueSliderValue,
          opacitySliderValue: opacitySliderValue ?? this.opacitySliderValue);
}
