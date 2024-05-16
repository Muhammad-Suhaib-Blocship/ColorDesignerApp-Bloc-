import 'dart:convert';

import 'package:color_designer_app_bloc/model/color_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../document_file.dart';

class SavedColorScreen extends StatefulWidget {
  const SavedColorScreen({Key? key}) : super(key: key);

  @override
  State<SavedColorScreen> createState() => _SavedColorScreenState();
}

class _SavedColorScreenState extends State<SavedColorScreen> {
  late SharedPreferences prefs;
  int lengthOfColorDetailsList = 0;
  List<ColorModel> decodedData = [];
  List<String>? stringData = [];
  Future<int> lengthOfList() async {
    // SharedPreferences.setMockInitialValues({});
    SharedPreferences sp = await SharedPreferences.getInstance();
    await SharedPreferences.getInstance();
    sp.getStringList("colorData");
    // print("lengths: ${sp.getStringList("colorData").length}");
    final colorData = sp.getStringList("colorData") ?? [];
    print('colorData: $colorData');
    decodedData =
        colorData.map((e) => ColorModel.fromJson(json.decode(e))).toList();

    print("decodedData ${decodedData.runtimeType}");
    print("decodedData ${decodedData}");
    return lengthOfColorDetailsList;
  }

  readFromSharedPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await SharedPreferences.getInstance();
    List<String>? stringData = sp.getStringList("key");
    if (stringData != null) {
      stringData.map((e) => ColorModel.fromJson(json.decode(e))).toList();
      setState(() {});
      print("stringData $stringData");
    } else {
      stringData = [];
      print("stringData $stringData");
    }
  }

  //
  Future<List> decodedColorData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.getStringList("colorData");
    print("lengths: ${sp.getStringList("colorData")!.length}");
    final colorData = sp.getStringList("colorData") ?? [];

    print('colorData: $colorData');
    // decodedData =
    final type =
        colorData.map<Map<String, dynamic>>((e) => json.decode(e)).toList();
    // ColorModel.fromJson(type);

    print('type: ${type.runtimeType}');
    print("decodedData ${decodedData}");
    return decodedData;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      prefs = await SharedPreferences.getInstance();
    });

    lengthOfList();
    readFromSharedPreferences();
    decodedColorData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Library"),
      ),
      body: ListView.builder(
        itemCount: decodedData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: const BoxDecoration(color: Colors.grey),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Color.fromRGBO(
                            (decodedData[index].value.r),
                            (decodedData[index].value.g),
                            (decodedData[index].value.b),
                            (decodedData[index].value.o.toDouble())),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Color Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(decodedData[index].color_name),
                          Text(decodedData[index].color_description),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("R: ${decodedData[index].value.r ?? 0}"),
                      Text("G: ${decodedData[index].value.g ?? 0}"),
                      Text("B: ${(decodedData[index].value.b ?? 0)}"),
                      Text("O: ${(decodedData[index].value.o ?? 0)}"),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
