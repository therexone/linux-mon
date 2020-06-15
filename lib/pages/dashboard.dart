import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage(this.stream);
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
                    snapshot.data.toString(),
                    style: TextStyle(color: Colors.white)
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
