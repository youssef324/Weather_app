
class City {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  City({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }


  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          country == other.country;

  @override
  int get hashCode => name.hashCode ^ country.hashCode;
}
