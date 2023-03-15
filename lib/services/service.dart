import '../constants.dart';
import '../models/city.dart';
import 'package:http/http.dart' as http;

class Service {

  Future<City?> getCityWeather(int cityID) async {
    String url = Constants.getWeather(cityID, Constants.apiKey);
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200){
      final json = response.body;
      return cityFromJson(json);
    }
    return null;
  }
}