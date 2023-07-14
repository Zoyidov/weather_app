import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/main/weather_main_model.dart';
import '../models/universal_data.dart';

class WeatherProvider {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static const String apiKeyForMain = "0e803bde5c469607eaceb4e3c535a798";

  static Future<UniversalData?> getMainWeatherDataByLatLong({
    required double lat,
    required double lon,
  }) async {
    Uri uri = Uri.parse("$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKeyForMain");

    try {
      http.Response response = await http.get(uri);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        WeatherMainModel weatherMainModel = WeatherMainModel.fromJson(jsonDecode(response.body));
        print(weatherMainModel);
        return UniversalData(data: weatherMainModel);
      }

      return UniversalData(error: "Error! Status code: ${response.statusCode}");
    } catch (err) {
      print(err); //
      return UniversalData(error: err.toString());
    }

  }

  static Future<UniversalData> getMainWeatherDataByQuery({
    required String query,
  }) async {
    Uri uri = Uri.parse("$baseUrl/weather?q=$query&appid=$apiKeyForMain");

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        return UniversalData(
          data: WeatherMainModel.fromJson(jsonDecode(response.body)),
        );
      }

      return UniversalData(error: "Error! Status code: ${response.statusCode}");
    } catch (err) {
      return UniversalData(error: err.toString());
    }
  }
}
