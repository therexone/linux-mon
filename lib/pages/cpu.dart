import 'package:flutter/material.dart';
import 'package:linux_mon/data_parser.dart';

class CpuPage extends StatelessWidget {
  CpuPage(this.stream);
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
                    DataParser.fromRawJson(snapshot.data).cpuFreq.toString(),
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
