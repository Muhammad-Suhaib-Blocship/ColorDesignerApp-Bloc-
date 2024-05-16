import 'dart:convert';

import 'package:color_designer_app_bloc/color_bloc/color_bloc.dart';
import 'package:color_designer_app_bloc/model/color_model.dart';
import 'package:color_designer_app_bloc/screen/saved_color_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../document_file.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // double _redSliderValue = 0;
  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  // final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  savedToSharedPreferences({cm, sp}) {
    List<String> colorDetailsString =
        colorDetails.map((e) => jsonEncode(cm.toJson())).toList();
    sp.setStringList("key", colorDetailsString);
  }

  @override
  Widget build(BuildContext context) {
    // int r = _redSliderValue.toInt();
    // int g = _greenSliderValue.toInt();
    // int b = _blueSliderValue.toInt();
    // double opacity = _opacitySliderValue;
    double max = 255;
    return BlocProvider(
      create: (context) => ColorBloc(),
      child: BlocBuilder<ColorBloc, ColorState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Color Designer"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SavedColorScreen(),
                          ));
                    },
                    icon: const Icon(Icons.save)),
              ],
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 120,
                      // backgroundColor: Colors.amber,
                      backgroundColor: Color.fromRGBO(
                          state.redSliderValue.toInt(),
                          state.greenSliderValue.toInt(),
                          state.blueSliderValue.toInt(),
                          state.opacitySliderValue),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(
                        width:

                            // double.infinity,
                            MediaQuery.of(context).size.width * 0.7,
                        child: Slider(
                            value: state.redSliderValue,
                            max: max,
                            activeColor: Colors.red,
                            onChanged: (double value) {
                              context.read<ColorBloc>().add(
                                  OnRedSliderValueUpdate(
                                      redSliderValue: value));
                              // setState(() {
                              //   _redSliderValue = value;
                              // });
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.green,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Slider(
                            value: state.greenSliderValue,
                            max: max,
                            activeColor: Colors.green,
                            onChanged: (double value) {
                              context.read<ColorBloc>().add(
                                  OnGreenSliderValueUpdate(
                                      greenSliderValue: value));
                              // setState(() {
                              //   _greenSliderValue = value;
                              // });
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Slider(
                            value: state.blueSliderValue,
                            max: max,
                            activeColor: Colors.blue,
                            onChanged: (double value) {
                              context.read<ColorBloc>().add(
                                  OnBlueSliderValueUpdate(
                                      blueSliderValue: value));
                              // setState(() {
                              //   _blueSliderValue = value;
                              // });
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black87,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Slider(
                            value: state.opacitySliderValue,
                            min: 0.0,
                            max: 1.0,
                            activeColor: Colors.black87,
                            onChanged: (double value) {
                              context.read<ColorBloc>().add(
                                  OnOpacitySliderValueUpdate(
                                      opacitySliderValue: value));
                              // setState(() {
                              //   _opacitySliderValue = value;
                              // });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.cyan,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            TextField(
                              controller: nameController,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  hintText: "Name",
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: descriptionController,
                              maxLines: 4,
                              cursorColor: Colors.cyan,
                              decoration: const InputDecoration(
                                  hintText: "Description",
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 50,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: const RoundedRectangleBorder(),
                                    backgroundColor: Colors.cyan,
                                  ),
                                  onPressed: () async {
                                    if (nameController.text.isEmpty ||
                                        descriptionController.text.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Please Enter Name and Description"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Ok"))
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      colorDetails.add(ColorModel(
                                          color_name: nameController.text,
                                          color_description:
                                              descriptionController.text,
                                          value: ValueModel(
                                              r: state.redSliderValue.toInt(),
                                              g: state.greenSliderValue.toInt(),
                                              b: state.blueSliderValue.toInt(),
                                              o: state.opacitySliderValue)));

                                      // SharedPreferences.setMockInitialValues({});
                                      SharedPreferences sp =
                                          await SharedPreferences.getInstance();
                                      ValueModel valueModel = ValueModel(
                                          r: state.redSliderValue.toInt(),
                                          g: state.greenSliderValue.toInt(),
                                          b: state.blueSliderValue.toInt(),
                                          o: state.opacitySliderValue);
                                      ColorModel cm = ColorModel(
                                          color_name: nameController.text,
                                          color_description:
                                              descriptionController.text,
                                          value: valueModel);
                                      savedToSharedPreferences(cm: cm, sp: sp);
                                      sp.setStringList(
                                          "colorData",
                                          colorDetails
                                              .map((e) =>
                                                  json.encode(e.toJson()))
                                              .toList());

                                      context.read<ColorBloc>().add(
                                          OnValueResetter(
                                              redSliderValue:
                                                  state.redSliderValue,
                                              greenSliderValue:
                                                  state.greenSliderValue,
                                              blueSliderValue:
                                                  state.blueSliderValue,
                                              opacitySliderValue:
                                                  state.opacitySliderValue));
                                      nameController.clear();
                                      descriptionController.clear();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text("Save")),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child:
                  const CircleAvatar(radius: 25, child: Icon(Icons.download)),
            ),
          );
        },
      ),
    );
  }
}
