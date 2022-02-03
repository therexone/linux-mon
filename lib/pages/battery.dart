import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/data_parser.dart';
import '../widgets/radial_progress.dart';

class BatteryPage extends StatefulWidget {
  BatteryPage(this.stream);

  final Stream? stream;

  @override
  _BatteryPageState createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage>
    with AutomaticKeepAliveClientMixin {
  // @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        DataParser? data;
        if (snapshot.hasData) {
          data = dataParserFromJson(snapshot.data.toString());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              snapshot.hasData
                  ? Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('POWER', style: kHeadingTextStyle),
                          RadialProgress(
                            radians: -90,
                            radiusDenominator: 2,
                            dataUnit: "%",
                            dataFontSize: 48,
                            dataPercentage: data!.batteryPercentage,
                            subtitle: 'BATTERY LEVEL',
                          ),
                          Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: bottomBatteryPart(data)
                                      /*
                                [
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
                                */
                                      ),
                                ),
                                powerIcon(data),
                                // data.plugged
                                //     ? Image.asset('assets/charging-flash.png', height: 22,)
                                //     : Image.asset('assets/on-battery.png'),
                              ],
                            ),
                          )
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
                    ),
            ],
          ),
        );
      },
    );
  }
}

List<Widget> bottomBatteryPart(DataParser pieceOfData) {
  List<Widget> retList = [];
  if (pieceOfData.plugged == "true") {
    retList.add(Text('PLUGGED IN', style: kCardHeadingTextStyle));
    retList
        .add(Text('Connected to AC Supply', style: kCardSubHeadingTextStyle));
  } else if (pieceOfData.plugged == "false") {
    retList.add(Text('ON BATTERY', style: kCardHeadingTextStyle));
    retList.add(remainingTimeBeautified(pieceOfData));
  } else {
    retList.add(Text('UNKNOWN POWER STATUS', style: kCardHeadingTextStyle));
    retList.add(remainingTimeBeautified(pieceOfData));
  }
  return retList;
}

Widget powerIcon(DataParser pieceOfData) {
  Widget retWiget;
  if (pieceOfData.plugged == 'true') {
    retWiget = Image.asset('assets/charging-flash.png', height: 22);
  } else if (pieceOfData.plugged == 'false') {
    retWiget = Image.asset('assets/on-battery.png');
  } else {
    retWiget = Icon(Icons.battery_unknown_sharp, size: 30);
  }
  return retWiget;
}

Text remainingTimeBeautified(DataParser data) {
  String beauTime = "";
  int h = data.approxSecLeft ~/ 3600;
  if (h > 0) {
    if (h > 1) {
      beauTime += "$h Hrs ";
    } else {
      beauTime += "$h Hr ";
    }
  }
  int m = (data.approxSecLeft % 3600) ~/ 60;
  if (m > 0) {
    if (m > 1) {
      beauTime += "$m Mins ";
    } else {
      beauTime += "$m Min ";
    }
  }

  if (data.approxSecLeft < 60 && beauTime == "") {
    beauTime = 'Less Than a Min ';
  }
  return Text(
      (data.approxSecLeft > 0)
          ? 'Approximately ' + beauTime + 'left'
          : (data.approxSecLeft == -2)
              ? "Device Plugged In"
              : (data.approxSecLeft == -3)
                  ? "Calculating Remaining Time..."
                  : "Unknown Remaining Time",
      style: kCardSubHeadingTextStyle);
}
