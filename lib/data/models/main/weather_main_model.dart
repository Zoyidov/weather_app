import 'coord_model.dart';
import 'main_in_main.dart';
import 'sys_in_main.dart';
import 'weather_model.dart';
import 'wind_in_main.dart';

class WeatherMainModel {
  final CoordModel coord;
  final List<WeatherModel> weather;
  final String base;
  final MainInMain main;
  final int visibility;
  final WindInMain wind;
  final int clouds;
  final int dt;
  final SysInMain sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  WeatherMainModel({
    required this.sys,
    required this.wind,
    required this.coord,
    required this.id,
    required this.name,
    required this.cod,
    required this.dt,
    required this.base,
    required this.clouds,
    required this.main,
    required this.timezone,
    required this.visibility,
    required this.weather,
  });

  factory WeatherMainModel.fromJson(Map<String, dynamic> json) {
    return WeatherMainModel(
      sys: SysInMain.fromJson(json["sys"]),
      wind: WindInMain.fromJson(json["wind"]),
      coord: CoordModel.fromJson(json["coord"]),
      id: json["id"],
      name: json["name"],
      cod: json["cod"],
      dt: json["dt"],
      base: json["base"],
      clouds: json["clouds"]["all"],
      main: MainInMain.fromJson(json["main"]),
      timezone: json["timezone"],
      visibility: json["visibility"],
      weather: (json["weather"] as List)
          .map((e) => WeatherModel.fromJson(e))
          .toList(),
    );
  }

  double? get temperature => main.temperature;
  double? get minTemperature => main.minTemperature;
  double? get maxTemperature => main.maxTemperature;
  double? get feelsLikeTemperature => main.feelsLikeTemperature;
  String? get description => weather.isNotEmpty ? weather[0].description : null;
  String? get icon => weather.isNotEmpty ? weather[0].icon : null;
}
