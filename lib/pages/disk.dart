import 'package:flutter/material.dart';
import 'package:linux_mon/utils/constants.dart';
import 'package:linux_mon/utils/data_parser.dart';
import 'package:linux_mon/widgets/radial_progress.dart';

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
        DataParser data;
        if (snapshot.hasData) {
          data = dataParserFromJson(snapshot.data);
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
                child: Text('RAM & DISK', style: kHeadingTextStyle),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.45,
                      margin: EdgeInsets.only(
                        top: 100.0,
                      ),
                      child: RadialProgress(
                        dataPercentage: snapshot.hasData
                            ? data.diskData.percentageUsed
                            : null,
                        subtitle: 'DISK USAGE',
                        radians: 90.0,
                        radiusDenominator: 2.8,
                        dataFontSize: 28.0,
                        blueGradient: true,
                      ),
                    ),
                    Container(
                      width: width * 0.5,
                      padding: EdgeInsets.zero,
                      child: RadialProgress(
                        dataPercentage: snapshot.hasData
                            ? data.ramData.percentageUsed.floorToDouble()
                            : null,
                        subtitle: 'RAM USAGE',
                        radiusDenominator: 2.4,
                        dataFontSize: 36.0,
                      ),
                    )
                  ],
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
                            data1: (data.ramData.available / 1000000000).toStringAsFixed(1),
                            data2: (data.ramData.total / 1000000000).toStringAsFixed(0),
                            desc: 'RAM AVAILABLE',
                          ),
                          RowDataCard(
                            size: size,
                            data1: (data.diskData.free / 1000000000).toStringAsFixed(1),
                            data2: (data.diskData.total / 1000000000).toStringAsFixed(0),
                            desc: 'DISK SPACE REMAINING',
                          ),
                          RowDataCard(
                            size: size,
                            data1: ((data.swapData.total - data.swapData.free) / 1000000000).toStringAsFixed(1),
                            data2: (data.swapData.total / 1000000000).toStringAsFixed(0),
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

class RowDataCard extends StatelessWidget {
  const RowDataCard({
    Key key,
    @required this.size,
    @required this.desc,
    @required this.data1,
    @required this.data2,
  }) : super(key: key);

  final Size size;
  final String data1;
  final String data2;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 32.0, top: 16.0, bottom: 16.0),
      height: size.height * 0.075,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: kCardBoxDecoration,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: VerticalDivider(
              thickness: 3,
              width: 0,
              color: Color(0xff2EFFB4),
            ),
          ),
          Expanded(child: Text(desc)),
          Text(
            data1,
            style: kCardHeadingTextStyle,
          ),
          Text(
            ' /$data2 GiB',
            style: kSubtitleTextStyle,
          )
        ],
      ),
    );
  }
}
