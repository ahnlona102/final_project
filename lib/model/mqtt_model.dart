class MQTT {
  final String? temperature;
  final String? humidity;

  MQTT({this.temperature, this.humidity});

  factory MQTT.fromJson(Map<String, dynamic> parsedJson) {
    return MQTT(
      temperature: parsedJson['Temperature'].toString(),
      humidity: parsedJson['Humidity'].toString(),
    );
  }
  @override
  String toString() {
    return "{Temperature: $temperature - Humidity: $humidity}";
  }
}

