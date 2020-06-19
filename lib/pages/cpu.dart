import 'package:flutter/material.dart';
import 'package:linux_mon/utils/data_parser.dart';

class CpuPage extends StatefulWidget {
  CpuPage(this.stream);
  final Stream stream;

  @override
  _CpuPageState createState() => _CpuPageState();
}

class _CpuPageState extends State<CpuPage> with AutomaticKeepAliveClientMixin {
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
                  child: Column(
                    children: [
                     
                      Text(
                        DataParser.fromRawJson(snapshot.data)
                            .cpuFreq
                            .toString(),
                        // style: TextStyle(color: Colors.white)
                      ),
                    ],
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
