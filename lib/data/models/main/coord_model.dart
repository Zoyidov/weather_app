class CoordModel {
  final double lon;
  final double lat;

  CoordModel({
    required this.lat,
    required this.lon,
  });

  factory CoordModel.fromJson(Map<String, dynamic> json) {
    return CoordModel(
      lat: json["lat"].toDouble(),
      lon: json["lon"].toDouble(),
    );
  }
}
