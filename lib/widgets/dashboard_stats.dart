import 'package:flutter/material.dart';
import '../utils/constants.dart';

class DashboardStats extends StatelessWidget {
  final String data;
  final String unit;
  final String iconPath;
  final String desc;

  const DashboardStats({
    required this.data,
    required this.unit,
    required this.iconPath,
    required this.desc,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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