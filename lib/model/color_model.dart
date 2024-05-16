import 'dart:convert';

class ColorModel {
  final String color_name;
  final String color_description;
  ValueModel value;

  ColorModel(
      {required this.color_name,
      required this.color_description,
      required this.value});

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
        color_name: json["color_name"],
        color_description: json["color_description"],
        value: ValueModel.fromJson(json["value"]));
  }
  Map<String, dynamic> toJson() {
    return {
      "color_name": color_name,
      "color_description": color_description,
      "value": value.toJson()
    };
  }
}

class ValueModel {
  final int r;
  final int g;
  final int b;
  final double o;
  ValueModel(
      {required this.r, required this.g, required this.b, required this.o});

  factory ValueModel.fromJson(Map<String, dynamic> json) =>
      ValueModel(r: json["r"], g: json["g"], b: json["b"], o: json["o"]);

  Map<String, dynamic> toJson() {
    return {
      "r": r,
      "g": g,
      "b": b,
      "o": o,
    };
  }

  static String encode(List<ColorModel> colorDetails) => json.encode(
        colorDetails
            .map<Map<String, dynamic>>((colorDetails) => colorDetails.toJson())
            .toList(),
      );

  static List<ColorModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<ColorModel>((item) => ColorModel.fromJson(item))
          .toList();
}

// {color_name: new color, color_description: sadfdfsa, value: {r: 255, g: 114, b: 75, o: 1}}, {color_name: dsfgfg, color_description: dhfg, value: {r: 255, g: 114, b: 154, o: 1},}
