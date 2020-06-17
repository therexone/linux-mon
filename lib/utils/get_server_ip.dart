import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

Future<String> getServerIP() async {
  final String ip = await Wifi.ip;
  final String subnet = ip.substring(0, ip.lastIndexOf('.'));
  final int port = 5678;
  String serverIP;

  final stream = NetworkAnalyzer.discover2(subnet, port);

  await for (NetworkAddress addr in stream) {
    if (addr.exists) {
      print('Found device: ${addr.ip}');
      serverIP = addr.ip;
      break;
    }
  }

  return serverIP;
}
