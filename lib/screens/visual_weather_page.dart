import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getData(widget.city);
  }

  City? cityWeather;
  int? temperature;
  String? state;
  DateTime? dt;
  String? skyStateAsset;

  bool isLoaded = false;
  bool isNight = false;

  Color backgroundColor = Constants.bgColorDay;

  _getData(Citys city) async {
    int? id = Constants.cityID[city];
    if (id != null) {
      try {
        cityWeather = await Service().getCityWeather(id);
        if (cityWeather != null) {
          setState(() {
            ListElement currentWeather = cityWeather!.list[0];
            temperature = currentWeather.main.tempInCelsius();
            state = currentWeather.weather.main;
            dt = currentWeather.dtTxt;

            backgroundColor = (dt!.hour < 6 || dt!.hour > 18) ? Constants.bgColorNight :
            (state == Constants.stateMainStr[SkyState.rain]) ? Constants.bgColorCloudyDay : Constants.bgColorDay;

            isNight = (dt!.hour < 6 || dt!.hour > 18);

            Constants.stateMainStr.forEach((key, value) {
              if (value == state) {
                skyStateAsset = Constants.stateAsset[key];
              }
            });

            isLoaded = true;

            // if (kDebugMode) {
            //   print("weather");
            //   print("temperature $temperature");
            //   print("state $state");
            //   print("dt $dt");
            // }
          });
        }
        else {
          setState(() {
            errorMessage = "Não foi possível obter a informação do\nOpenWeather";
            isLoaded = true;
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = "Ocorreu um problema com a\n conexão à\nAPI OpenWeather";
          isLoaded = true;
        });
      }
    }
    else {
      setState(() {
        errorMessage = "Não foi possível obter o id correto da cidade";
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.cityName[widget.city] ?? "Cidade"),
        backgroundColor: Constants.bgColorAppBar,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),),
      ),
      backgroundColor: backgroundColor,
      body:
        (!isLoaded) ?
          // Circular Progress Indicator
          const Center(
            child: SpinKitCircle(
              size: 100,
              color: Colors.white,
            )
          )
        :
        Column(
          children: [
            Expanded(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // DateTime
                (() {
                  try {
                    return Center(child: Text("${dt!.day}-${dt!.month}-${dt!.year} "
                    "${dt!.hour}:${(dt!.minute < 10) ? '0' : ''}${dt!.minute}"
                    ":${(dt!.minute < 10) ? '0' : ''}${dt!.second}",
                    style: const TextStyle(fontSize: 30, color: Constants.textColor),),);
                  }
                  catch (e) {
                    // if (errorMessage == '') {
                    //   errorMessage = "Não foi possível carregar os dados";
                    // }
                    return const Center(child: Text("---------- --:--:--",
                      style: TextStyle(fontSize: 30, color: Constants.textColor),),);
                  }
                }()),

                // 3D Visualizer
                (() {
                  try {
                    return SizedBox(
                      height: 300,
                      child: Center(
                        child: ModelViewer(
                          src: skyStateAsset!,
                          autoRotate: true,
                          //cameraControls: false,
                          disableZoom: true,
                          // disablePan: true,
                          rotationPerSecond: "30deg",
                    ),),);
                  } catch (e) {
                    setState(() {
                      if (errorMessage == '') {
                        errorMessage = "Não foi possível carregar a imagem";
                      }
                    });
                    return const SizedBox(height: 300, child: Image(image: AssetImage(Constants.noImageImg)),);
                  }
                }()),

                // Temperature
                Center(child: Text("${(temperature == null) ? '--' : temperature} ºC",
                      style: const TextStyle(fontSize: 70, color: Constants.textColor,
                          fontWeight: FontWeight.bold),),),
              ],),),

            Center(child: Text(errorMessage, style: TextStyle(fontSize: 15,
                color: (isNight) ? Constants.errorLightColor : Constants.errorDarkColor),),),

            (errorMessage == '') ?
            const SizedBox(height: 40,)
            :
            const SizedBox(height: 15,)
          ],),
    );
  }
}