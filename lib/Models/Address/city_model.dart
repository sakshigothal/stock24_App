// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
    CityModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.result,
    });

    List<CityResult>? result;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: List<CityResult>.from(json["result"].map((x) => CityResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class CityResult {
    CityResult({
        this.id,
        this.cityName,
    });

    int? id;
    String? cityName;

    factory CityResult.fromJson(Map<String, dynamic> json) => CityResult(
        id: json["id"],
        cityName: json["city_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city_name": cityName,
    };
}
