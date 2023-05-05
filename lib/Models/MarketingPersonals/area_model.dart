// To parse this JSON data, do
//
//     final areaModel = areaModelFromJson(jsonString);

import 'dart:convert';

AreaModel areaModelFromJson(String str) => AreaModel.fromJson(json.decode(str));

String areaModelToJson(AreaModel data) => json.encode(data.toJson());

class AreaModel {
    AreaModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
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
        this.area,
        this.countries,
        this.aboutUs,
    });

    List<Area>? area;
    List<Country>? countries;
    String? aboutUs;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        area: List<Area>.from(json["area"].map((x) => Area.fromJson(x))),
        countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
        aboutUs: json["about_us"],
    );

    Map<String, dynamic> toJson() => {
        "area": List<dynamic>.from(area!.map((x) => x.toJson())),
        "countries": List<dynamic>.from(countries!.map((x) => x.toJson())),
        "about_us": aboutUs,
    };
}

class Area {
    Area({
        this.key,
        this.value,
    });

    String? key;
    String? value;

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
    };
}

class Country {
    Country({
        this.id,
        this.countryName,
    });

    int? id;
    String? countryName;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        countryName: json["country_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "country_name": countryName,
    };
}
