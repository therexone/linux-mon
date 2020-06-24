import 'package:flutter/material.dart';
import 'package:linux_mon/utils/constants.dart';



class RowDataCard extends StatelessWidget {
  const RowDataCard({
    Key key,
    @required this.size,
    @required this.desc,
    @required this.data1,
    @required this.data2,
  }) : super(key: key);

  final Size size;
  final String data1;
  final String data2;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24.0, top: 16.0, bottom: 16.0),
      height: size.height * 0.075,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: kCardBoxDecoration,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: VerticalDivider(
              thickness: 3,
              width: 0,
              color: Color(0xff2EFFB4),
            ),
          ),
          Expanded(child: Text(desc)),
          Text(
            data1,
            style: kCardHeadingTextStyle,
          ),
          Text(
            ' /$data2 GiB',
            style: kSubtitleTextStyle,
          )
        ],
      ),
    );
  }
}

