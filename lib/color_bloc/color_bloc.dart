import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState.initial()) {
    on<OnRedSliderValueUpdate>((event, emit) => onRedSliderValue(event, emit));
    on<OnGreenSliderValueUpdate>(
        (event, emit) => onGreenSliderValue(event, emit));
    on<OnBlueSliderValueUpdate>(
        (event, emit) => onBlueSliderValue(event, emit));
    on<OnOpacitySliderValueUpdate>(
        (event, emit) => onOpacitySliderValue(event, emit));
    on<OnValueResetter>((event, emit) => onValueResetter(event, emit));
  }

  void onRedSliderValue(OnRedSliderValueUpdate event, emit) {
    emit(state.copyWith(redSliderValue: event.redSliderValue));
  }

  void onGreenSliderValue(OnGreenSliderValueUpdate event, emit) {
    emit(state.copyWith(greenSliderValue: event.greenSliderValue));
  }

  void onBlueSliderValue(OnBlueSliderValueUpdate event, emit) {
    emit(state.copyWith(blueSliderValue: event.blueSliderValue));
  }

  void onOpacitySliderValue(OnOpacitySliderValueUpdate event, emit) {
    emit(state.copyWith(opacitySliderValue: event.opacitySliderValue));
  }

  void onValueResetter(OnValueResetter event, emit) {
    emit(state.copyWith(
        redSliderValue: 0,
        blueSliderValue: 0,
        greenSliderValue: 0,
        opacitySliderValue: 0));
  }
}
