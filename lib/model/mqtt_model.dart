class MQTT {
  final double? temperature;
  final double? humidity;

  MQTT({this.temperature, this.humidity});

  factory MQTT.fromJson(Map<String, dynamic> parsedJson) {
    return MQTT(
      temperature: double.parse(parsedJson['Temperature']),
      humidity: double.parse(parsedJson['Humidity']),
    );
  }

  @override
  String toString() {
    return "{Temperature: $temperature - Humidity: $humidity}";
  }
}