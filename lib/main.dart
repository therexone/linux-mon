import 'package:flutter/material.dart';
import 'linux_mon.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LinuxMon",
      theme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.black
    
      ),
      home: LinuxMon(),
    );
  }
}



// try {
//   _deviceDataStream = IOWebSocketChannel.connect("ws://192.168.43.59:5678")
//       .stream
//       .asBroadcastStream();
//   // _deviceDataStream.listen((event) {
//   //   var data = DataParser.fromRawJson(event);
//   //   print(data.cpuFreq);
//   // });
// } catch (e) {
//   print(e);
// }
