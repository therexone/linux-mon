import 'package:flutter/material.dart';
import 'package:linux_mon/pages/battery.dart';
import './data_parser.dart';
import './icons.dart';
import './utils/get_server_ip.dart';
import 'package:web_socket_channel/io.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'pages/cpu.dart';
import 'pages/dashboard.dart';
import 'pages/disk.dart';
import 'pages/temperatures.dart';
import 'utils/get_server_ip.dart';

void main() => runApp(LinuxMon());

class LinuxMon extends StatefulWidget {
  @override
  _LinuxMonState createState() => _LinuxMonState();
}

class _LinuxMonState extends State<LinuxMon> {
  String _websocketIP;
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final BatteryPage _batteryPage = BatteryPage();
  final CpuPage _cpuPage = CpuPage();
  final DashboardPage _dashboardPage = DashboardPage();
  final DiskPage _diskPage = DiskPage();
  final TemperaturesPage _temperaturesPage = TemperaturesPage();

  Widget _showPage = DashboardPage();

  Widget _pageSelector(int page) {
    switch (page) {
      case 0:
        return _batteryPage;
      case 1:
        return _cpuPage;
      case 2:
        return _dashboardPage;
      case 3:
        return _diskPage;
      case 4:
        return _temperaturesPage;
      default:
        return Center(child: Text('bruh really?'),);
    }
  }

  @override
  void initState() {
    super.initState();
    getServerIP().then((ip) => _websocketIP = ip);
  }

  @override
  Widget build(BuildContext context) {
    print(_websocketIP);

    // Stream _deviceDataStream;
    // try {
    //   _deviceDataStream = IOWebSocketChannel.connect("ws://192.168.43.59:5678")
    //       .stream
    //       .asBroadcastStream();
    //   _deviceDataStream.listen((event) {
    //     var data = DataParser.fromRawJson(event);
    //      print(data.cpuFreq);
    //   });
    // } catch (e) {
    //   print(e);
    // }
    // print(_websocketIP);

    return MaterialApp(
      home: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            // height: 50.0,
            items: <Widget>[
              Icon(CustomIcons.ibat2, size: 20),
              Icon(CustomIcons.ichart_bar, size: 20),
              Icon(CustomIcons.ichart_alt, size: 20),
              Icon(CustomIcons.ihdd, size: 20),
              Icon(CustomIcons.itemperatire, size: 20),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.black87,
            animationCurve: Curves.easeInOutCubic,
            animationDuration: Duration(milliseconds: 400),
            onTap: (index) {
              setState(() {
                _showPage = _pageSelector(index);
              });
            },
          ),
          body: Container(
            color: Colors.black87,
            child: _showPage
          )),
    );
  }
}
// StreamBuilder(
//           stream: _deviceDataStream,
//           builder: (context, snapshot) {
//             return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: snapshot.hasData
//                     ?  Table(
//                         children: [
//                           TableRow(children: [
//                             TableCell(
//                               child: Text('cell 1'),
//                             ),
//                             TableCell(
//                               child: Text('cell 2'),
//                             ),
//                           ])
//                         ],
//                       )
//                     : Center(child: Text('No data')));
//           },
//         ),
