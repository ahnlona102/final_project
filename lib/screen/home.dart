import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:IntelliHome/global/common/client_mqtt.dart';
import 'package:IntelliHome/model/mqtt_model.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:IntelliHome/constants/app_colors.dart';
import 'package:IntelliHome/model/smart_home_model.dart';
import 'package:IntelliHome/screen/room_card.dart';
import 'package:IntelliHome/screen/widgets/drawer.dart';
import 'package:flutter/services.dart';

import '../model/mqtt_helper.dart';
import 'Notification/notification_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<String> tempDataNotifier = ValueNotifier("0");
  ValueNotifier<String> humidityDataNotifier = ValueNotifier("0");
  late ValueNotifier<bool> _isConnectMQTTNotifier;
  String? weatherPrediction;

  // INITIALIZE USERNAME VARIABLE
  late String username = '';
  // TRACK USER'S LOGIN STATUS
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // CALL FUNCTION TO RETRIEVE USERNAME
    // connect();
    if (clientMQTT.client?.connectionStatus!.state !=
        MqttConnectionState.connected) {
      connectMQTT(_connectSuccess, _connectFailed);
    }
    getUsername();
  }

  void _connectSuccess() {
    print('Connect success!!!');
    _listenerHandleData();
  }

  void _connectFailed() {
    print('Connect failed!!!');
    Future.delayed(const Duration(milliseconds: 1000), () {
      connectMQTT(_connectSuccess, _connectFailed);
    });
  }

  void _listenerHandleData() {
    print('123 listen data');
    clientMQTT.client?.updates?.listen(
      (List<MqttReceivedMessage<MqttMessage?>>? c) {
        print('-----------------------');
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        if (c[0].topic == clientMQTT.topic) {
          final jsonData = jsonDecode(pt);
          final dataMQTT = MQTT.fromJson(jsonData);
          print("data: $dataMQTT");
          tempDataNotifier.value = '${dataMQTT.temperature}';
          print("data: ${tempDataNotifier.value}");
          // Dự đoán thời tiết từ dữ liệu MQTT
          weatherPrediction =
              predictWeather(dataMQTT.temperature!, dataMQTT.humidity!);

          setState(() {});
        } else {
          print('TOPIC ${c[0].topic}!!!');
        }

        // print("Received message: $pt from topic: ${c[0].topic}");
        // print("data: $pt");
      },
    );
  }

  String? predictWeather(double temperature, double humidity) {
    if (temperature > 25 && humidity > 60) {
      return "Mưa";
    } else if (temperature <= 25 && humidity > 60) {
      return "Mưa";
    } else if (temperature > 25 && humidity <= 60) {
      return "Nắng";
    }
    return null;
  }

  // FETCH USERNAME FROM FIRESTORE
  Future<void> getUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        username = userSnapshot['username'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: CustomDrawer(
          // isLoggedIn: isLoggedIn
          ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) {
                            return IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(Icons.menu),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationScreen()),
                            );
                          },
                          icon: Icon(Icons.notifications),
                        ),
                      ],
                    ),

                    // DISPLAY TEMPERATURE AND ADD BUTTON
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.device_thermostat_outlined,
                              size: 40,
                            ),
                            ValueListenableBuilder(
                              valueListenable: tempDataNotifier,
                              builder: (context, value, child) => Text(
                                "${value}\u00b0",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 90,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(8),
                        ),
                      ],
                    ),

                    // DISPLAY WELCOME
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Chào mừng quay trở lại",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColor.fgColor.withOpacity(.5),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    // DISPLAY WEATHER
                    Container(
                      width: double.infinity,
                      height: 70,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 5,
                                color: AppColor.black.withOpacity(.1)),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            bottomLeft: Radius.circular(35),
                          )),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColor.fgColor.withOpacity(.1),
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.wb_cloudy_sharp,
                              size: 30,
                              color: AppColor.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Thời tiết hôm nay: ${weatherPrediction ?? 'Loading...'}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),

                    // DISPLAY ALL ROOM
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Rooms",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(Icons.arrow_forward_ios)
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),

            // ROOM CARD
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: smartHomeData.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0 || smartHomeData.length + 1 == index) {
                    return Container(
                      width: 15,
                      height: size.height * 0.5,
                      color: Colors.transparent,
                    );
                  }

                  final data = smartHomeData[index - 1];

                  return RoomCard(roomData: data);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
