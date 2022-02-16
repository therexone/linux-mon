import 'package:flutter/material.dart';
import 'linux_mon.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(App()),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LinuxMon",
      theme: ThemeData(
          fontFamily: 'Poppins',
          brightness: Brightness.dark,
          canvasColor: Color(0xff0F0F11)),
      home: LinuxMon(),
    );
  }
}
