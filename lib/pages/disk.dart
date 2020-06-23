import 'package:flutter/material.dart';
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
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        DataParser data;
        if (snapshot.hasData) {
          data = dataParserFromJson(snapshot.data);
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: snapshot.hasData
              ? Column(
                children: [
                    RadialProgress()
                ],
              )
              : Center(
                  child: Text('No data'),
                ),
        );
      },
    );
  }
}
