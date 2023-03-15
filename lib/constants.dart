
import 'dart:ui';

enum Citys {
  coimbra,
  faro,
  leiria,
  lisboa,
  porto
}

class Constants {
  static const String appTitle = "Weather App";

  static const int lisboaID =  2267056;
  static const int leiriaID =  2267094;
  static const int coimbraID = 2740636;
  static const int portoID =   2735941;
  static const int faroID =    2268337;

  static Map<Citys, int> cityID = {
    Citys.coimbra: coimbraID,
    Citys.faro:    faroID,
    Citys.leiria:  leiriaID,
    Citys.lisboa:  lisboaID,
    Citys.porto:   portoID};

  static Map<Citys, String> cityName = {
    Citys.coimbra: "Coimbra",
    Citys.faro:    "Faro",
    Citys.leiria:  "Leiria",
    Citys.lisboa:  "Lisboa",
    Citys.porto:   "Porto"};

  static const String apiKey = "";

  static const Color bgColorAppBar = Color.fromRGBO(70, 160, 190, 1);
  static const Color bgColorDay =    Color.fromRGBO(150, 240, 250, 0.85);
  static const Color bgColorNight =  Color.fromRGBO(45, 55, 83, 1);

  static String getWeather(int cityID, String apiKey){
    return "http://api.openweathermap.org/data/2.5/forecast?id=$cityID&APPID=$apiKey";
  }
}
