import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import "package:r_get_ip/r_get_ip.dart";

Future<String?> getServerIP() async {
  final String ip = await RGetIp.internalIP ?? '';
  final String subnet = ip.substring(0, ip.lastIndexOf('.'));
  final int port = 5678;
  String? serverIP = '';

  final stream = NetworkAnalyzer.discover2(subnet, port);

  await for (NetworkAddress addr in stream) {
    if (addr.exists) {
      serverIP = addr.ip;
      break;
    }
  }
  return serverIP;
}
