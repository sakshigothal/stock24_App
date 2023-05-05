// To parse this JSON data, do
//
//     final getMarketingPersonals = getMarketingPersonalsFromJson(jsonString);

import 'dart:convert';

GetMarketingPersonals getMarketingPersonalsFromJson(String str) => GetMarketingPersonals.fromJson(json.decode(str));

String getMarketingPersonalsToJson(GetMarketingPersonals data) => json.encode(data.toJson());

class GetMarketingPersonals {
    GetMarketingPersonals({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory GetMarketingPersonals.fromJson(Map<String, dynamic> json) => GetMarketingPersonals(
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
        this.totalRecords,
    });

    List<Result>? result;
    int? totalRecords;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        totalRecords: json["total_records"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "total_records": totalRecords,
    };
}

class Result {
    Result({
        this.id,
        this.name,
        this.designation,
        this.mobileNumber,
        this.whatsappNumber,
        this.area,
    });

    int? id;
    String? name;
    String? designation;
    String? mobileNumber;
    String? whatsappNumber;
    String? area;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        designation: json["designation"],
        mobileNumber: json["mobile_number"],
        whatsappNumber: json["whatsapp_number"],
        area: json["area"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "designation": designation,
        "mobile_number": mobileNumber,
        "whatsapp_number": whatsappNumber,
        "area": area,
    };
}
