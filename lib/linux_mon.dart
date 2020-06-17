import 'package:flutter/material.dart';
import 'package:linux_mon/pages/battery.dart';
import './icons.dart';
import './utils/get_server_ip.dart';
import 'package:web_socket_channel/io.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'pages/cpu.dart';
import 'pages/dashboard.dart';
import 'pages/disk.dart';
import 'pages/temperatures.dart';
import 'utils/get_server_ip.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LinuxMon extends StatefulWidget {
  @override
  _LinuxMonState createState() => _LinuxMonState();
}

class _LinuxMonState extends State<LinuxMon> {
  static String _websocketUrl = 'ws://0.0.0.0';
  static IOWebSocketChannel channel = IOWebSocketChannel.connect(_websocketUrl);
  static Stream deviceDataStream = channel.stream.asBroadcastStream();

  static List<Widget> _pages = [
    BatteryPage(deviceDataStream),
    CpuPage(deviceDataStream),
    DashboardPage(deviceDataStream),
    DiskPage(deviceDataStream),
    TemperaturesPage(deviceDataStream),
  ];

  PageController pageController;
  int _selectedIndex = 0;

  wserror(err) async {
    print(new DateTime.now().toString() + " Connection error: $err");
    await reconnect();
  }

  reconnect() async {
    if (channel != null) {
      await Future.delayed(Duration(seconds: 4));
    }
    setState(() {
      print(new DateTime.now().toString() + " Starting connection attempt...");
      channel = IOWebSocketChannel.connect(_websocketUrl);
      print(new DateTime.now().toString() + " Connection attempt completed.");
      deviceDataStream = channel.stream.asBroadcastStream();
      _pages = [
        BatteryPage(deviceDataStream),
        CpuPage(deviceDataStream),
        DashboardPage(deviceDataStream),
        DiskPage(deviceDataStream),
        TemperaturesPage(deviceDataStream),
      ];
    });
    deviceDataStream.listen((data) => print('got data'),
        onDone: reconnect, onError: wserror, cancelOnError: true);
  }

  void setupStream() {
    String websocketIp;
    getServerIP().then((ip) {
      if (ip == null) {
        throw ('no servers found');
      }
      websocketIp = ip;
      _websocketUrl = 'ws://$websocketIp:5678';
      deviceDataStream.listen((data) => print('got data'),
          onDone: reconnect, onError: wserror, cancelOnError: true);
    }).catchError((e) {
      print('could not get server');
      Future.delayed(Duration.zero, () {
        showAlertDialog(context);
      });
    });
    // return websocketIp;
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    setupStream();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Rescan"),
      onPressed: () {
        setupStream();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Rescan"),
      content: Text("Could find any servers!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (_websocketUrl == null) print(_websocketUrl);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          FlatButton(
            child: Text(
              'Reconnect',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setupStream();
            },
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
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
        onTap: _onTapped,
      ),
      body: PageView(
        children: _pages,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
