import 'package:flutter/material.dart';
import 'package:linux_mon/utils/constants.dart';
import 'package:linux_mon/utils/data_parser.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage(this.stream);
  final Stream stream;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        DataParser data;
        if (snapshot.hasData) {
          data = dataParserFromJson(snapshot.data);
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: snapshot.hasData
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'DASHBOARD',
                      style: kHeadingTextStyle,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(
                            colors: [Color(0xffFF512F), Color(0xffDD2476)],
                            stops: [0.194, 0.9706]),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/pc.png',
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              data.user,
                              style: kCardHeadingTextStyle,
                            )
                          ]),
                    ),
                    Text('CONNECTED DEVICE', style: kSubtitleTextStyle),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Divider(
                        height: 0,
                        color: Color(0xff24242E),
                        thickness: 2.0,
                      ),
                    ),
                    GridView.count(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                      shrinkWrap: true,
                      childAspectRatio: size.height / size.width * 0.70,
                      crossAxisCount: 2,
                      primary: false,
                      crossAxisSpacing: width * 0.025,
                      mainAxisSpacing: width * 0.03,
                      children: [
                        DashboardStats(
                          data: data.cpuFreq[0].toStringAsFixed(0),
                          iconPath: 'assets/current-cspeed.png',
                          unit: 'MHz',
                          desc: 'CLOCK SPEED',
                        ),
                        DashboardStats(
                          data: data.batteryPercentage.toStringAsFixed(0),
                          iconPath: 'assets/on-battery-bigger.png',
                          unit: '%',
                          desc: 'BATTERY LEVEL',
                        ),
                        DashboardStats(
                          data:
                              data.sensorTemperatures.coretemp[0][1].toString(),
                          iconPath: 'assets/temperature.png',
                          unit: 'C',
                          desc: 'CORE TEMPERATURE',
                        ),
                        DashboardStats(
                          data: data.diskUsage.toStringAsFixed(0),
                          iconPath: 'assets/disk-usage.png',
                          unit: '%',
                          desc: 'DISK USAGE',
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, bottom: size.height * 0.025),
                      child: DashboardRamCard(
                        data: data.ramUsage.toStringAsFixed(0),
                        iconPath: 'assets/ram.png',
                        unit: '%',
                        desc: 'CURRENT RAM USAGE',
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text('No data'),
                ),
        );
      },
    );
  }
}

class DashboardStats extends StatelessWidget {
  final String data;
  final String unit;
  final String iconPath;
  final String desc;

  const DashboardStats({
    Key key,
    this.data,
    this.unit,
    this.iconPath,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 30.0,
            height: 30.0,
          ),
          Row(
            textBaseline: TextBaseline.ideographic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              Text(
                unit,
                style: TextStyle(color: Color(0xff868689), fontSize: 12.0),
              )
            ],
          ),
          Text(
            desc,
            style: kSubtitleTextStyle,
          )
        ],
      ),
    );
  }
}

class DashboardRamCard extends StatelessWidget {
  final String data;
  final String unit;
  final String iconPath;
  final String desc;

  const DashboardRamCard(
      {Key key, this.data, this.unit, this.iconPath, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kCardBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            iconPath,
            width: 30.0,
            height: 30.0,
          ),
          Row(
            textBaseline: TextBaseline.ideographic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              Text(
                unit,
                style: TextStyle(color: Color(0xff868689), fontSize: 12.0),
              )
            ],
          ),
          Text(
            desc,
            style: kSubtitleTextStyle,
          )
        ],
      ),
    );
  }
}
