import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/data_parser.dart';
import '../widgets/radial_progress.dart';
import '../widgets/ram_data_card.dart';

class DiskPage extends StatefulWidget {
  DiskPage(this.stream);
  final Stream stream;

  @override
  _DiskPageState createState() => _DiskPageState();
}

class _DiskPageState extends State<DiskPage>
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
        DataParser? data;
        if (snapshot.hasData) {
          data = dataParserFromJson(snapshot.data!.toString());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: Text('RAM & DISK', style: kHeadingTextStyle),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.01),
                  child: Stack(
                    children: [
                      Container(
                        width: width * 0.45,
                        margin: EdgeInsets.only(
                          top: 100.0,
                          right: width * 0.35
                        ),
                        child: RadialProgress(
                          dataUnit: "%",
                          dataPercentage: snapshot.hasData
                              ? data!.diskData.percentageUsed
                              : 0,
                          subtitle: 'DISK USAGE',
                          radians: 90.0,
                          radiusDenominator: 2.8,
                          dataFontSize: 28.0,
                          blueGradient: true,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width * 0.35),
                        width: width * 0.5,
                        padding: EdgeInsets.zero,
                        child: RadialProgress(
                          radians: -90,
                          dataUnit: "%",
                          dataPercentage: snapshot.hasData
                              ? data!.ramData.percentageUsed.floorToDouble()
                              : 0,
                          subtitle: 'RAM USAGE',
                          radiusDenominator: 2.4,
                          dataFontSize: 36.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              snapshot.hasData
                  ? Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RowDataCard(
                            size: size,
                            data1: (data!.ramData.available / 1000000000)
                                .toStringAsFixed(1),
                            data2: (data.ramData.total / 1000000000)
                                .toStringAsFixed(0),
                            desc: 'RAM AVAILABLE',
                          ),
                          RowDataCard(
                            size: size,
                            data1: (data.diskData.free / 1000000000)
                                .toStringAsFixed(1),
                            data2: (data.diskData.total / 1000000000)
                                .toStringAsFixed(0),
                            desc: 'DISK SPACE REMAINING',
                          ),
                          RowDataCard(
                            size: size,
                            data1: ((data.swapData.total - data.swapData.free) /
                                    1000000000)
                                .toStringAsFixed(1),
                            data2: (data.swapData.total / 1000000000)
                                .toStringAsFixed(0),
                            desc: 'SWAP USAGE',
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: Text(
                        'DISCONNECTED',
                        style: TextStyle(
                            color: Color(0xff869EA5),
                            fontWeight: FontWeight.w200,
                            fontSize: 14.0,
                            letterSpacing: 2),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
