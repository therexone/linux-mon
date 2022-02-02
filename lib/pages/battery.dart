import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/data_parser.dart';
import '../widgets/radial_progress.dart';

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
        var data = snapshot.hasData ? dataParserFromJson(snapshot.data!.toString()) : null;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('POWER', style: kHeadingTextStyle),
              RadialProgress(
                radians: -90,
                radiusDenominator: 2,
                dataUnit: "%",
                dataFontSize: 48,
                dataPercentage:
                    snapshot.hasData ? data!.batteryPercentage : 0,
                    subtitle: 'BATTERY LEVEL',
              ),
              snapshot.hasData
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 15.0),
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: kCardBoxDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                data!.plugged
                                    ? Text('PLUGGED IN',
                                        style: kCardHeadingTextStyle)
                                    : Text('ON BATTERY',
                                        style: kCardHeadingTextStyle),
                                data.plugged
                                    ? Text('Connected to AC Supply',
                                        style: kCardSubHeadingTextStyle)
                                    : Text('Approximately ${(data.approxSecLeft ~/ 60)} Mins left',
                                        style: kCardSubHeadingTextStyle)
                              ],
                            ),
                          ),
                          data.plugged
                              ? Image.asset('assets/charging-flash.png', height: 22,)
                              : Image.asset('assets/on-battery.png'),
                        ],
                      ),
                    )
                  : Text(
                      'DISCONNECTED',
                      style: TextStyle(
                          color: Color(0xff869EA5),
                          fontWeight: FontWeight.w200,
                          fontSize: 14.0,
                          letterSpacing: 2),
                    )
            ],
          ),
        );
      },
    );
  }
}
