
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../constants.dart';
import '../models/city.dart';
import '../services/service.dart';

class VisualWeatherPage extends StatefulWidget {
  const VisualWeatherPage({Key? key, required this.city}) : super(key: key);

  final Citys city;

  @override
  State<VisualWeatherPage> createState() => _VisualWeatherPageState();
}

class _VisualWeatherPageState extends State<VisualWeatherPage> {

  late Object skyState;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.light));
    }
    _getData(widget.city);
  }

  City? cityWeather;
  int? temperature;
  String? state;
  DateTime? dt;

  bool isLoaded = false;
  Color backgroundColor = Constants.bgColorDay;

  _getData(Citys city) async {
    int? id = Constants.cityID[city];
    if (id == null) {return;}
    cityWeather = await Service().getCityWeather(id);
    if (cityWeather == null) {return;}

    setState(() {
      ListElement currentWeather = cityWeather!.list[0];
      temperature = currentWeather.main.tempInCelsius();
      state = currentWeather.weather.main;
      dt = currentWeather.dtTxt;

      backgroundColor = (dt!.hour < 6 || dt!.hour > 18 ) ?
      Constants.bgColorNight : Constants.bgColorDay;
      isLoaded = true;

      skyState = Object(fileName: "assets/rain/Project Name.obj");
      // if (kDebugMode) {
      //   print("weather");
      //   print("temperature $temperature");
      //   print("state $state");
      //   print("dt $dt");
      // }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.cityName[widget.city] ?? "Cidade"),
        backgroundColor: Constants.bgColorAppBar,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: backgroundColor,
      body:
        Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Center(
            child: ModelViewer(src: 'assets/Untitled.glb')
            // child: Cube(onSceneCreated: (Scene scene) {
            //   scene.world.add(Object(fileName: 'assets/rain/Project Name.obj',));
            //   scene.camera.zoom = 4;
            //
            // }),
          ),
        ),
    );
  }
}