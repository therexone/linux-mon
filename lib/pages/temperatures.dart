import 'package:flutter/material.dart';
import 'package:linux_mon/utils/constants.dart';
import 'package:linux_mon/utils/data_parser.dart';
import 'package:linux_mon/widgets/cpu_stats_card.dart';
import 'package:linux_mon/widgets/radial_progress.dart';

class TemperaturesPage extends StatefulWidget {
  TemperaturesPage(this.stream);
  final Stream stream;

  @override
  _TemperaturesPageState createState() => _TemperaturesPageState();
}

class _TemperaturesPageState extends State<TemperaturesPage>
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
        List tempData;
        if (snapshot.hasData) {
          tempData =
              dataParserFromJson(snapshot.data).sensorTemperatures.acpitz[0];
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'TEMPERATURES',
                style: kHeadingTextStyle,
              ),
              RadialProgress(
                dataPercentage: snapshot.hasData ? tempData[1] : null,
                dataUnit: ' °C',
                subtitle: 'ACPITZ TEMPERATURE',
                radiusDenominator: 2.25,
                dataFontSize: 36.0,
              ),
              snapshot.hasData
                  ? GridView.count(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                      shrinkWrap: true,
                      childAspectRatio: size.height / size.width * 0.75,
                      crossAxisCount: 2,
                      primary: false,
                      crossAxisSpacing: width * 0.025,
                      mainAxisSpacing: width * 0.03,
                      children: [
                        StatsCard(
                          cardString: 'Current Temperature',
                          dataUnit: ' °C',
                          data: tempData[1],
                          cardImgPath: 'assets/current-cspeed.png',
                        ),
                        StatsCard(
                            cardString: 'Max Temperature',
                            data: tempData[2],
                            dataUnit: ' °C',
                            cardImgPath: 'assets/max-cspeed.png'),
                        StatsCard(
                            cardString: 'Critical Temperature',
                            data: tempData[3],
                            dataUnit: ' °C',
                            cardImgPath: 'assets/max-cspeed.png')
                      ],
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
