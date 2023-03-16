
import 'dart:ui';

enum Citys {
  coimbra,
  faro,
  leiria,
  lisboa,
  porto
}

enum SkyState {
  rain,
  clouds,
  sun
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

  static Map<SkyState, String> stateMainStr = {
    SkyState.rain :   "Rain",
    SkyState.clouds : "Clouds",
    SkyState.sun :    "Clear"
  };

  static Map<SkyState, String> stateAsset = {
    SkyState.rain :   "assets/rain.glb",
    SkyState.clouds : "assets/cloud.glb",
    SkyState.sun :    "assets/sun.glb"
  };

  static const String apiKey = "7bb78224c14db81f46bc1d6f86a3e8c3";

  static const String errorMessage = '';

  static const Color bgColorAppBar =    Color.fromRGBO(70, 160, 190, 1);
  static const Color bgColorDay =       Color.fromRGBO(150, 240, 250, 0.85);
  static const Color bgColorCloudyDay = Color.fromRGBO(150, 240, 250, 0.5);
  static const Color bgColorNight =     Color.fromRGBO(45, 55, 83, 1);
  static const Color textColor =        Color.fromRGBO(255, 255, 255, 1);
  static const Color errorColor =       Color.fromRGBO(50, 50, 50, 0.65);

  static String getWeather(int cityID, String apiKey){
    return "http://api.openweathermap.org/data/2.5/forecast?id=$cityID&APPID=$apiKey";
  }
}
