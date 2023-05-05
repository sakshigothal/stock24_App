// To parse this JSON data, do
//
//     final finishModel = finishModelFromJson(jsonString);

import 'dart:convert';

FinishModel finishModelFromJson(String str) => FinishModel.fromJson(json.decode(str));

String finishModelToJson(FinishModel data) => json.encode(data.toJson());

class FinishModel {
    FinishModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory FinishModel.fromJson(Map<String, dynamic> json) => FinishModel(
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

    List<FinishResult>? result;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: List<FinishResult>.from(json["result"].map((x) => FinishResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class FinishResult {
    FinishResult({
        this.finish,
    });

    String? finish;

    factory FinishResult.fromJson(Map<String, dynamic> json) => FinishResult(
        finish: json["finish"],
    );

    Map<String, dynamic> toJson() => {
        "finish": finish,
    };
}
