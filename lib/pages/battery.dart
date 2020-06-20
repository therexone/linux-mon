import 'package:flutter/material.dart';
import 'package:linux_mon/radial_progress.dart';
import 'package:linux_mon/utils/data_parser.dart';

class BatteryPage extends StatefulWidget {
  BatteryPage(this.stream);
  final Stream stream;

  @override
  _BatteryPageState createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        var data =
            snapshot.hasData ? DataParser.fromRawJson(snapshot.data) : null;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'POWER',
                style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff869EA5),
                ),
              ),
              RadialProgress(
                batteryPercentage: snapshot.hasData ? data.batteryPercentage: null,
              ),
              snapshot.hasData
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 15.0),
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color(0xff24242E),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                data.plugged
                                    ? Text(
                                        'PLUGGED IN',
                                        style: TextStyle(
                                            color: Color(0xfff9f9f9),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      )
                                    : Text('ON BATTERY',
                                        style: TextStyle(
                                            color: Color(0xfff9f9f9),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0)),
                                data.plugged
                                    ? Text('Connected to AC Supply',
                                        style: TextStyle(
                                            color: Color(0xff869EA5),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12.0))
                                    : Text('Using Battery power',
                                        style: TextStyle(
                                            color: Color(0xff869EA5),
                                            fontWeight: FontWeight.w200,
                                            fontSize: 12.0))
                              ],
                            ),
                          ),
                          data.plugged ? Image.asset('assets/charging-flash.png'): Image.asset('assets/on-battery.png'),
                        ],
                      ),
                    )
                  : Text('DISCONNECTED',
                      style: TextStyle(
                          color: Color(0xff869EA5),
                          fontWeight: FontWeight.w200,
                          fontSize: 14.0,
                          letterSpacing: 2))
            ],
          ),
        );
      },
    );
  }
}
