import 'dart:convert';

DataParser dataParserFromJson(String str) => DataParser.fromJson(json.decode(str));

String dataParserToJson(DataParser data) => json.encode(data.toJson());

class DataParser {
    DataParser({
        required this.user,
        required this.cpuFreq,
        required this.ramData,
        required this.diskData,
        required this.swapData,
        required this.sensorTemperatures,
        required this.batteryPercentage,
        required this.plugged,
        required this.approxSecLeft,
    });

    String user;
    List<double> cpuFreq;
    RamData ramData;
    Data diskData;
    Data swapData;
    SensorTemperatures sensorTemperatures;
    double batteryPercentage;
    bool plugged;
    int approxSecLeft;

    factory DataParser.fromJson(Map<String, dynamic> json) => DataParser(
        user: json["user"],
        cpuFreq: List<double>.from(json["cpu_freq"].map((x) => x.toDouble())),
        ramData: RamData.fromJson(json["ram_data"]),
        diskData: Data.fromJson(json["disk_data"]),
        swapData: Data.fromJson(json["swap_data"]),
        sensorTemperatures: SensorTemperatures.fromJson(json["sensor_temperatures"]),
        batteryPercentage: json["battery_percentage"].toDouble(),
        plugged: json["plugged"]??false,
        approxSecLeft: json["approx_sec_left"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "cpu_freq": List<dynamic>.from(cpuFreq.map((x) => x)),
        "ram_data": ramData.toJson(),
        "disk_data": diskData.toJson(),
        "swap_data": swapData.toJson(),
        "sensor_temperatures": sensorTemperatures.toJson(),
        "battery_percentage": batteryPercentage,
        "plugged": plugged,
        "approx_sec_left": approxSecLeft,
    };
}

class Data {
    Data({
        required this.percentageUsed,
        required this.total,
        required this.free,
    });

    double percentageUsed;
    int total;
    int free;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        percentageUsed: json["percentage_used"].toDouble(),
        total: json["total"],
        free: json["free"],
    );

    Map<String, dynamic> toJson() => {
        "percentage_used": percentageUsed,
        "total": total,
        "free": free,
    };
}

class RamData {
    RamData({
        this.percentageUsed=0,
        this.total=0,
        this.available=0,
    });

    double percentageUsed;
    int total;
    int available;

    factory RamData.fromJson(Map<String, dynamic> json) => RamData(
        percentageUsed: json["percentage_used"].toDouble(),
        total: json["total"],
        available: json["available"],
    );

    Map<String, dynamic> toJson() => {
        "percentage_used": percentageUsed,
        "total": total,
        "available": available,
    };
}

class SensorTemperatures {
    SensorTemperatures({
        required this.acpitz,
    });

    List<List<dynamic>> acpitz;
    List<List<dynamic>>? pchSkylake;
    List<List<dynamic>>? coretemp;

    factory SensorTemperatures.fromJson(Map<String, dynamic> json) => SensorTemperatures(
        acpitz: List<List<dynamic>>.from(json["acpitz"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "acpitz": List<dynamic>.from(acpitz.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
