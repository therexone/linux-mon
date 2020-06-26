import 'package:flutter/material.dart';
import 'package:linux_mon/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart' as url;



class DisconnectedColumn extends StatelessWidget {
  const DisconnectedColumn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          children: [
            Text(
              'DISCONNECTED',
              style: kHeadingTextStyle,
            ),
            Text(
              'NO DATA AVAILABLE',
              style: kSubtitleTextStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '- Make sure the server daemon is running on your device',
              style: kSubtitleTextStyle,
            ),
            Text(
              '- Your phone and the linux device should be on the same network',
              style: kSubtitleTextStyle,
            ),
            Image.asset('assets/error.png'),
            InkWell(
              onTap: () async {
                await url.launch(
                    'https://github.com/therexone/linuxMon/readme.md');
              },
              child: Text(
                '- More help - https://github.com/therexone/linuxMon/readme.md',
                style: TextStyle(
                    color: Color(0xff11DFDE),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      );
  }
}
