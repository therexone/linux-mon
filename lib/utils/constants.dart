import 'package:flutter/material.dart';

const kHeadingTextStyle = TextStyle(
  fontSize: 18.0,
  letterSpacing: 4,
  fontWeight: FontWeight.w600,
  color: Color(0xff869EA5),
);

const kCardHeadingTextStyle = TextStyle(
    color: Color(0xfff9f9f9), fontWeight: FontWeight.w600, fontSize: 14.0);

const kCardSubHeadingTextStyle = TextStyle(
    color: Color(0xff869EA5), fontWeight: FontWeight.w300, fontSize: 12.0);

const kSubtitleTextStyle = TextStyle(
    color: Color(0xff868689), fontSize: 12.0, fontWeight: FontWeight.w300);

LinearGradient kPrimaryLinearGradient = LinearGradient(
    colors: [Color(0xffC464FF), Color(0xffFB4ABF), Color(0xffFB4A4A)],
    stops: [0.0, 0.4976, 0.9768]);

LinearGradient kSecondaryLinearGradient = LinearGradient(
    colors: [Color(0xff2EFFB4), Color(0xff4ADBFB), Color(0xff0EE0DA)],
    stops: [0.0, 0.4901, 1.0]);

var kCardBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  color: Color(0xff24242E),
);
