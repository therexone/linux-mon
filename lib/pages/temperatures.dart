import 'package:flutter/material.dart';

import '../data_parser.dart';

class TemperaturesPage extends StatelessWidget {
  TemperaturesPage( this.stream);
  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: snapshot.hasData
              ? Center(
                  child: Text(
                    DataParser.fromRawJson(snapshot.data).sensorTemperatures.coretemp.toString(),
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
