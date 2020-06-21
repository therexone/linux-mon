import 'package:flutter/material.dart';
import 'package:linux_mon/utils/data_parser.dart';

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
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: snapshot.hasData
              ? Center(
                  child: Text(
                    dataParserFromJson(snapshot.data) 
                        .sensorTemperatures
                        .coretemp
                        .toString(),
                    // style: TextStyle(color: Colors.white)
                  ),
                )
              : Center(
                  child: Text('No data'),
                ),
        );
      },
    );
  }
}


