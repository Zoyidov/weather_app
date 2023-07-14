class MainInMain {
  final double? temperature;
  final double? feelsLikeTemperature;
  final double? minTemperature;
  final double? maxTemperature;
  final int? pressure;
  final int? humidity;

  MainInMain({
    this.temperature,
    this.feelsLikeTemperature,
    this.minTemperature,
    this.maxTemperature,
    this.pressure,
    this.humidity,
  });

  factory MainInMain.fromJson(Map<String, dynamic> json) {
    return MainInMain(
      temperature: json["temp"] as double?,
      feelsLikeTemperature: json["feels_like"] as double?,
      minTemperature: json["temp_min"] as double?,
      maxTemperature: json["temp_max"] as double?,
      pressure: json["pressure"] as int?,
      humidity: json["humidity"] as int?,
    );
  }

}
