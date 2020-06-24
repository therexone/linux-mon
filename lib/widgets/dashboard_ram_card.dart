import 'package:flutter/material.dart';
import 'package:linux_mon/utils/constants.dart';

class DashboardRamCard extends StatelessWidget {
  final String data;
  final String unit;
  final String iconPath;
  final String desc;

  const DashboardRamCard(
      {Key key, this.data, this.unit, this.iconPath, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kCardBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            iconPath,
            width: 30.0,
            height: 30.0,
          ),
          Row(
            textBaseline: TextBaseline.ideographic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              Text(
                unit,
                style: TextStyle(color: Color(0xff868689), fontSize: 12.0),
              )
            ],
          ),
          Text(
            desc,
            style: kSubtitleTextStyle,
          )
        ],
      ),
    );
  }
}
