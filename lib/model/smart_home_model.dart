import 'package:flutter/material.dart';
List<String> listTopic = [
  'ESP32/LIGHT/Data',
  'ESP32/LIGHT2/Data',
  'ESP32/LIGHT3/Data',
  'ESP32/LIGHT4/Data',
  'ESP32/RELAY/data',

];
class SmartHomeModel {
  String roomName;
  String roomImage;
  String roomTemperature;
  int userAccess;
  bool roomStatus;
  List<DeviceInRoom>? devices;
  SmartHomeModel({
    required this.roomName,
    required this.roomImage,
    required this.roomTemperature,
    required this.userAccess,
    this.roomStatus = false,
    this.devices,
  });
}

class DeviceInRoom {
  String deviceName;
  IconData iconOn;
  IconData iconOff;
  bool deviceStatus;
  String? topicLight;
  String? topicRelay;
  DeviceInRoom({
    required this.deviceName,
    required this.iconOn,
    required this.iconOff,
    this.deviceStatus = false,
    this.topicLight,
    this.topicRelay,
  });
}

List<SmartHomeModel> smartHomeData = [
  SmartHomeModel(
    roomName: "Phòng khách",
    roomImage: "assets/images/livingroom.jpg",
    roomTemperature: "25°",
    userAccess: 4,
    roomStatus: true,
    devices: [
      DeviceInRoom(
        deviceName: "Light",
        iconOn: Icons.lightbulb_rounded,
        iconOff: Icons.lightbulb_outline_rounded,
        deviceStatus: true,
          topicLight: 'ESP32/LIGHT/Data'
      ),
      DeviceInRoom(
        deviceName: "Fan",
        iconOn: Icons.wind_power,
        iconOff: Icons.mode_fan_off_outlined,
        deviceStatus: true,
          topicRelay: 'ESP32/RELAY/data'
      ),
      DeviceInRoom(
        deviceName: "Độ ẩm",
        iconOn: Icons.air,
        iconOff: Icons.mode_fan_off_outlined,
        deviceStatus: false,
      ),
      DeviceInRoom(
        deviceName: "AC",
        iconOn: Icons.ac_unit,
        iconOff: Icons.thermostat,
        deviceStatus: true,
      ),
      DeviceInRoom(
        deviceName: "Home Theater",
        iconOn: Icons.speaker_outlined,
        iconOff: Icons.volume_off_outlined,
        deviceStatus: false,
      ),
    ],
  ),
  SmartHomeModel(
    roomName: "Phòng ngủ",
    roomImage: "assets/images/bedroom.jpg",
    roomTemperature: "25°",
    userAccess: 1,
    roomStatus: true,
    devices: [
      DeviceInRoom(
        deviceName: "Light",
        iconOn: Icons.lightbulb_rounded,
        iconOff: Icons.lightbulb_outline_rounded,
        deviceStatus: true,
        topicLight: 'ESP32/LIGHT3/Data'
      ),
      DeviceInRoom(
        deviceName: "Fan",
        iconOn: Icons.air,
        iconOff: Icons.mode_fan_off_outlined,
        deviceStatus: true,
          topicRelay: 'ESP32/RELAY/data'
      ),
      DeviceInRoom(
        deviceName: "Độ ẩm",
        iconOn: Icons.air,
        iconOff: Icons.mode_fan_off_outlined,
        deviceStatus: false,
      ),
      DeviceInRoom(
        deviceName: "AC",
        iconOn: Icons.ac_unit,
        iconOff: Icons.thermostat,
        deviceStatus: true,
      ),
    ],
  ),
  SmartHomeModel(
    roomName: "Hành lang",
    roomImage: "assets/images/hallway.jpg",
    roomTemperature: "25°",
    userAccess: 4,
    roomStatus: true,
    devices: [
      DeviceInRoom(
        deviceName: "Light",
        iconOn: Icons.lightbulb_rounded,
        iconOff: Icons.lightbulb_outline_rounded,
        deviceStatus: true,
          topicLight: 'ESP32/LIGHT2/Data'
      ),
      DeviceInRoom(
        deviceName: "Fan",
        iconOn: Icons.air,
        iconOff: Icons.mode_fan_off_outlined,
        deviceStatus: true,
          topicRelay: 'ESP32/RELAY/data'

      ),
      DeviceInRoom(
        deviceName: "AC",
        iconOn: Icons.ac_unit,
        iconOff: Icons.thermostat,
        deviceStatus: true,
      ),
    ],
  ),
  SmartHomeModel(
    roomName: "Nhà bếp",
    roomImage: "assets/images/kitchen.jpg",
    roomTemperature: "25°",
    userAccess: 2,
    roomStatus: true,
    devices: [
      DeviceInRoom(
        deviceName: "Light",
        iconOn: Icons.lightbulb_rounded,
        iconOff: Icons.lightbulb_outline_rounded,
        deviceStatus: true,
          topicLight: 'ESP32/LIGHT2/Data'

      ),
      DeviceInRoom(
        deviceName: "Fan",
        iconOn: Icons.air,
        iconOff: Icons.mode_fan_off_outlined,
        deviceStatus: true,
          topicRelay: 'ESP32/RELAY/data'
      ),
      DeviceInRoom(
        deviceName: "AC",
        iconOn: Icons.ac_unit,
        iconOff: Icons.thermostat,
        deviceStatus: true,
      ),
    ],
  ),
  SmartHomeModel(
    roomName: "Phòng tắm",
    roomImage: "assets/images/bathroom.jpg",
    roomTemperature: "25°",
    userAccess: 3,
    roomStatus: true,
    devices: [
      DeviceInRoom(
        deviceName: "Light",
        iconOn: Icons.lightbulb_rounded,
        iconOff: Icons.lightbulb_outline_rounded,
        deviceStatus: true,
          topicLight: 'ESP32/LIGHT4/Data'
      ),
      DeviceInRoom(
        deviceName: "Fan",
        iconOn: Icons.air,
        iconOff: Icons.mode_fan_off_outlined,
        deviceStatus: true,
          topicRelay: 'ESP32/RELAY/data'
      ),
      DeviceInRoom(
        deviceName: "AC",
        iconOn: Icons.ac_unit,
        iconOff: Icons.thermostat,
        deviceStatus: true,
      ),
    ],
  ),
];