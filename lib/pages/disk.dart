import 'package:flutter/material.dart';
import 'package:linux_mon/utils/data_parser.dart';

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
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: snapshot.hasData
              ? Center(
                  child: Text(
                    DataParser.fromRawJson(snapshot.data).diskUsage.toString(),
                    //  style: TextStyle(color: Colors.white),
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
