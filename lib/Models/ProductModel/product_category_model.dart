// To parse this JSON data, do
//
//     final productCategoryModel = productCategoryModelFromJson(jsonString);

import 'dart:convert';

ProductCategoryModel productCategoryModelFromJson(String str) => ProductCategoryModel.fromJson(json.decode(str));

String productCategoryModelToJson(ProductCategoryModel data) => json.encode(data.toJson());

class ProductCategoryModel {
    ProductCategoryModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => ProductCategoryModel(
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

    List<CategoryResult>? result;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: List<CategoryResult>.from(json["result"].map((x) => CategoryResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class CategoryResult {
    CategoryResult({
        this.id,
        this.categoryName,
    });

    int? id;
    String? categoryName;

    factory CategoryResult.fromJson(Map<String, dynamic> json) => CategoryResult(
        id: json["id"],
        categoryName: json["category_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
    };
}
