import 'package:IntelliHome/model/smart_home_model.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

ClientMQTT clientMQTT = ClientMQTT();

void connectMQTT(Function success, Function failed){
  clientMQTT.connect(success, failed);
}

class ClientMQTT {
  ClientMQTT();
  final String serverUri = 'broker.emqx.io';
  final String clientId = 'mqttx_583f73ca';
  final String topic = 'ESP32/DHT11/Data';
  MqttServerClient? client;

  Future<MqttServerClient?> connect(Function success, Function failed) async {
    print('mqtt connecting...');
    client = MqttServerClient(serverUri, clientId);
    client?.port = 1883;
    final MqttConnectMessage connMess = MqttConnectMessage()
        .keepAliveFor(60)
        .withWillTopic('willTopic')
        .withWillMessage('willMessage')
        .withWillQos(MqttQos.atMostOnce);

    client?.connectionMessage = connMess;
    try {
      await client?.connect();
    } catch (e) {
      print('Exception: $e');
    }
    if (client?.connectionStatus!.state == MqttConnectionState.connected) {
      client?.subscribe(topic, MqttQos.atMostOnce);
      client?.subscribe(listTopic[0], MqttQos.atMostOnce);
      client?.subscribe(listTopic[1], MqttQos.atMostOnce);
      client?.subscribe(listTopic[2], MqttQos.atMostOnce);
      client?.subscribe(listTopic[3], MqttQos.atMostOnce);

      success();
    } else {
      // print(
      //     "MQTT client connection failed, status is ${client?.connectionStatus}");
      // client?.disconnect();
      failed();
    }
    return client;
  }
}