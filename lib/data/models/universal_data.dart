import 'main/weather_main_model.dart';

class UniversalData {
  final WeatherMainModel? data;
  final String error;

  UniversalData({
    this.data,
    this.error = "",
  });
}
