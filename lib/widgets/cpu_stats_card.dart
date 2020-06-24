import 'package:flutter/material.dart';
import 'package:linux_mon/utils/constants.dart';


class CpuStatsCard extends StatelessWidget {
  final double clockSpeed;
  final String cardString;
  final String cardImgPath;

  const CpuStatsCard(
      {Key key, this.clockSpeed, this.cardString, this.cardImgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kCardBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(cardImgPath, width: 35.0,),
          Text(
            '${clockSpeed.toStringAsFixed(0) ?? '--'} MHz',
            style: kCardHeadingTextStyle,
          ),
          Text('$cardString Clock Speed', style: kCardSubHeadingTextStyle)
        ],
      ),
    );
  }
}
