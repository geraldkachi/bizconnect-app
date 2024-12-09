class City {
  final String name;
  final String countryCode;
  final String stateCode;
  final double latitude;
  final double longitude;

  City({
    required this.name,
    required this.countryCode,
    required this.stateCode,
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create a City from JSON data
  factory City.fromJson(List<String> json) {
    return City(
      name: json[0],
      countryCode: json[1],
      stateCode: json[2],
      latitude: double.parse(json[3]),
      longitude: double.parse(json[4]),
    );
  }

  // Method to convert the City instance to a map (useful for serializing)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'countryCode': countryCode,
      'stateCode': stateCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
