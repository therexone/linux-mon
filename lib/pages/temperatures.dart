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

   List _data1 = [
    {'name': DateTime.now().millisecondsSinceEpoch, 'value': 0}
  ];

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
         List acpitzData;
         SensorTemperatures sensorTemperatures;
        if (snapshot.hasData) {
          sensorTemperatures = dataParserFromJson(snapshot.data).sensorTemperatures;
          acpitzData = sensorTemperatures.acpitz;
          print(acpitzData);
        //   if (_data1.length > 20) {
        //     _data1.removeAt(0);
        //   }
        //   // _data1.add({
        //   //   'name': DateTime.now().millisecondsSinceEpoch,
        //   //   'value': clockspeed.round()
        //   // });
        //   // print(jsonData);
        //   // print(_data);
        // 
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: snapshot.hasData
              ? Center(
                  child: Text(
                   'burh'
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


