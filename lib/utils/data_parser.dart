import 'package:meta/meta.dart';
import 'dart:convert';

class DataParser {
  DataParser({
    @required this.user,
    @required this.cpuFreq,
    @required this.ramUsage,
    @required this.diskUsage,
    @required this.sensorTemperatures,
    @required this.batteryPercentage,
    @required this.plugged,
    @required this.approxSecLeft,
  });

  String user;
  List<double> cpuFreq;
  double ramUsage;
  double diskUsage;
  SensorTemperatures sensorTemperatures;
  double batteryPercentage;
  bool plugged;
  int approxSecLeft;

  factory DataParser.fromRawJson(String str) =>
      DataParser.fromJson(json.decode(str));

  factory DataParser.fromJson(Map<String, dynamic> json) => DataParser(
        user: json["user"],
        cpuFreq: List<double>.from(json["cpu_freq"].map((x) => x.toDouble())),
        ramUsage: json["ram_usage"].toDouble(),
        diskUsage: json["disk_usage"].toDouble(),
        sensorTemperatures:
            SensorTemperatures.fromJson(json["sensor_temperatures"]),
        batteryPercentage: json["battery_percentage"].toDouble(),
        plugged: json["plugged"],
        approxSecLeft: json["approx_sec_left"],
      );
}

class SensorTemperatures {
  SensorTemperatures({
    @required this.acpitz,
    @required this.pchSkylake,
    @required this.coretemp,
  });

  List<List<dynamic>> acpitz;
  List<List<dynamic>> pchSkylake;
  List<List<dynamic>> coretemp;

  factory SensorTemperatures.fromRawJson(String str) =>
      SensorTemperatures.fromJson(json.decode(str));

  factory SensorTemperatures.fromJson(Map<String, dynamic> json) =>
      SensorTemperatures(
        acpitz: List<List<dynamic>>.from(
            json["acpitz"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        pchSkylake: List<List<dynamic>>.from(json["pch_skylake"]
            .map((x) => List<dynamic>.from(x.map((x) => x)))),
        coretemp: List<List<dynamic>>.from(
            json["coretemp"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );
}
