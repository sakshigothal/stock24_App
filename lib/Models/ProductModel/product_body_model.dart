// To parse this JSON data, do
//
//     final productBodyModel = productBodyModelFromJson(jsonString);

import 'dart:convert';

ProductBodyModel productBodyModelFromJson(String str) => ProductBodyModel.fromJson(json.decode(str));

String productBodyModelToJson(ProductBodyModel data) => json.encode(data.toJson());

class ProductBodyModel {
    ProductBodyModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory ProductBodyModel.fromJson(Map<String, dynamic> json) => ProductBodyModel(
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

    List<BodyResult>? result;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: List<BodyResult>.from(json["result"].map((x) => BodyResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class BodyResult {
    BodyResult({
        this.body,
    });

    String? body;

    factory BodyResult.fromJson(Map<String, dynamic> json) => BodyResult(
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "body": body,
    };
}
