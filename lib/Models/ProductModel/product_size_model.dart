// To parse this JSON data, do
//
//     final productSizeModel = productSizeModelFromJson(jsonString);

import 'dart:convert';

ProductSizeModel productSizeModelFromJson(String str) => ProductSizeModel.fromJson(json.decode(str));

String productSizeModelToJson(ProductSizeModel data) => json.encode(data.toJson());

class ProductSizeModel {
    ProductSizeModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory ProductSizeModel.fromJson(Map<String, dynamic> json) => ProductSizeModel(
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

    List<SizeResult>? result;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: List<SizeResult>.from(json["result"].map((x) => SizeResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class SizeResult {
    SizeResult({
        this.size,
    });

    String? size;

    factory SizeResult.fromJson(Map<String, dynamic> json) => SizeResult(
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "size": size,
    };
}
