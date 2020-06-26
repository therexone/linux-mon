import 'package:flutter/material.dart';
import 'package:linux_mon/utils/constants.dart';

class StatsCard extends StatelessWidget {
  final double data;
  final String dataUnit;
  final String cardString;
  final String cardImgPath;

  const StatsCard(
      {Key key, this.data, this.cardString, this.cardImgPath, this.dataUnit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kCardBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            cardImgPath,
            width: 35.0,
          ),
          Text(
            '${data.toStringAsFixed(0) ?? '--'} $dataUnit',
            style: kCardHeadingTextStyle,
          ),
          Text('$cardString', style: kCardSubHeadingTextStyle)
        ],
      ),
    );
  }
}
