import 'package:flutter/material.dart';
import 'package:linux_mon/data_parser.dart';

class BatteryPage extends StatelessWidget {
  BatteryPage(this.stream);
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
                    DataParser.fromRawJson(snapshot.data).batteryPercentage.toStringAsFixed(2),
                    style: TextStyle(color: Colors.white)
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
