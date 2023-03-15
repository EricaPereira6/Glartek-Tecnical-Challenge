import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

class City {

  City({required this.list});

  List<ListElement> list;

  factory City.fromJson(Map<String, dynamic> json) => City(
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );
}

class ListElement {

  ListElement({required this.main, required this.weather, required this.dtTxt});

  Main main;
  Weather weather;
  DateTime dtTxt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    main: Main.fromJson(json["main"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x)))[0],
    dtTxt: DateTime.parse(json["dt_txt"]),
  );
}

class Main {

  Main({required this.temp});

  double temp;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"]?.toDouble(),
  );

  // String tempInCelsius() => (temp - 273.15).toStringAsFixed(1);
  int tempInCelsius() => (temp - 273.15).round();
}

class Weather {

  Weather({required this.main, required this.description});

  String main;
  String description;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    main: json["main"],
    description: json["description"],
  );
}