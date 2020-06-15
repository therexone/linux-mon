import 'package:flutter/material.dart';
import 'package:linux_mon/data_parser.dart';
import 'package:linux_mon/icons.dart';
import 'package:web_socket_channel/io.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

void main() => runApp(LinuxMon());

class LinuxMon extends StatefulWidget {
  @override
  _LinuxMonState createState() => _LinuxMonState();
}

class _LinuxMonState extends State<LinuxMon> {
  String _websocketIP;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  void getDevices() async {
    try {
      final String ip = await Wifi.ip;
      final String subnet = ip.substring(0, ip.lastIndexOf('.'));
      final int port = 5678;

      final stream = NetworkAnalyzer.discover2(subnet, port);
      stream.listen((NetworkAddress addr) {
        if (addr.exists) {
          print('Found device: ${addr.ip}');
          _websocketIP = addr.ip;
          return;
        }
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getDevices();
  }

  @override
  Widget build(BuildContext context) {
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
    print(_websocketIP);

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
            backgroundColor: Colors.blueAccent,
            animationCurve: Curves.easeInOutCubic,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
          ),
          body: Container(
            color: Colors.blueAccent,
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(_page.toString(), textScaleFactor: 10.0),
                  RaisedButton(
                    child: Text('Go To Page of index 1'),
                    onPressed: () {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(1);
                    },
                  )
                ],
              ),
            ),
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
