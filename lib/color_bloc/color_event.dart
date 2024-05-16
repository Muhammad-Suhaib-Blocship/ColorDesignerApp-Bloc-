part of 'color_bloc.dart';

abstract class ColorEvent {}

class OnRedSliderValueUpdate extends ColorEvent {
  final double redSliderValue;

  OnRedSliderValueUpdate({required this.redSliderValue});
}

class OnGreenSliderValueUpdate extends ColorEvent {
  final double greenSliderValue;

  OnGreenSliderValueUpdate({required this.greenSliderValue});
}

class OnBlueSliderValueUpdate extends ColorEvent {
  final double blueSliderValue;

  OnBlueSliderValueUpdate({required this.blueSliderValue});
}

class OnOpacitySliderValueUpdate extends ColorEvent {
  final double opacitySliderValue;

  OnOpacitySliderValueUpdate({required this.opacitySliderValue});
}

class OnValueResetter extends ColorEvent {
  final double redSliderValue;
  final double greenSliderValue;
  final double blueSliderValue;
  final double opacitySliderValue;

  OnValueResetter(
      {required this.redSliderValue,
      required this.greenSliderValue,
      required this.blueSliderValue,
      required this.opacitySliderValue});
}
