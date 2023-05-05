// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
    StateModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
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

    List<StateResult>? result;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: List<StateResult>.from(json["result"].map((x) => StateResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class StateResult {
    StateResult({
        this.id,
        this.stateName,
    });

    int? id;
    String? stateName;

    factory StateResult.fromJson(Map<String, dynamic> json) => StateResult(
        id: json["id"],
        stateName: json["state_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "state_name": stateName,
    };
}
