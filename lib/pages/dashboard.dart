import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage(this.stream);
  final Stream stream;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with AutomaticKeepAliveClientMixin {
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
                    snapshot.data.toString(),
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
