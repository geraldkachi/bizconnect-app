class StateProvinceModel {
  final String name;
  final String isoCode;
  final String countryCode;
  final String latitude;
  final String longitude;

  StateProvinceModel({
    required this.name,
    required this.isoCode,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
  });

  factory StateProvinceModel.fromJson(Map<String, dynamic> json) {
    return StateProvinceModel(
      name: json['name'],
      isoCode: json['isoCode'],
      countryCode: json['countryCode'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
