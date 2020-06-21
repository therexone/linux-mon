// import 'package:meta/meta.dart';
import 'dart:convert';


DataParser dataParserFromJson(String str) => DataParser.fromJson(json.decode(str));

String dataParserToJson(DataParser data) => json.encode(data.toJson());

class DataParser {
    DataParser({
        this.user,
        this.cpuFreq,
        this.ramUsage,
        this.diskUsage,
        this.sensorTemperatures,
        this.batteryPercentage,
        this.plugged,
        this.approxSecLeft,
    });

    String user;
    List<double> cpuFreq;
    double ramUsage;
    double diskUsage;
    SensorTemperatures sensorTemperatures;
    double batteryPercentage;
    bool plugged;
    int approxSecLeft;

    factory DataParser.fromJson(Map<String, dynamic> json) => DataParser(
        user: json["user"],
        cpuFreq: List<double>.from(json["cpu_freq"].map((x) => x.toDouble())),
        ramUsage: json["ram_usage"].toDouble(),
        diskUsage: json["disk_usage"].toDouble(),
        sensorTemperatures: SensorTemperatures.fromJson(json["sensor_temperatures"]),
        batteryPercentage: json["battery_percentage"].toDouble(),
        plugged: json["plugged"],
        approxSecLeft: json["approx_sec_left"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "cpu_freq": List<dynamic>.from(cpuFreq.map((x) => x)),
        "ram_usage": ramUsage,
        "disk_usage": diskUsage,
        "sensor_temperatures": sensorTemperatures.toJson(),
        "battery_percentage": batteryPercentage,
        "plugged": plugged,
        "approx_sec_left": approxSecLeft,
    };
}

class SensorTemperatures {
    SensorTemperatures({
        this.acpitz,
        this.pchSkylake,
        this.coretemp,
    });

    List<List<dynamic>> acpitz;
    List<List<dynamic>> pchSkylake;
    List<List<dynamic>> coretemp;

    factory SensorTemperatures.fromJson(Map<String, dynamic> json) => SensorTemperatures(
        acpitz: List<List<dynamic>>.from(json["acpitz"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        pchSkylake: List<List<dynamic>>.from(json["pch_skylake"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        coretemp: List<List<dynamic>>.from(json["coretemp"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "acpitz": List<dynamic>.from(acpitz.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "pch_skylake": List<dynamic>.from(pchSkylake.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "coretemp": List<dynamic>.from(coretemp.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
