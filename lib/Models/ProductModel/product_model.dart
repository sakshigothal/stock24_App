// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
        this.categoryId,
        this.productName,
        this.size,
        this.body,
        this.finish,
        this.tilesPerBox,
        this.sqmtrPerBox,
        this.sqftPerBox,
        this.price,
        this.mrp,
        this.productImages,
        this.category,
        this.batch,
    });

    int? id;
    String? categoryId;
    String? productName;
    String? size;
    String? body;
    String? finish;
    String? tilesPerBox;
    String? sqmtrPerBox;
    String? sqftPerBox;
    String? price;
    String? mrp;
    List<ProductImage>? productImages;
    String? category;
    List<Batch>? batch;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        categoryId: json["category_id"],
        productName: json["product_name"],
        size: json["size"],
        body: json["body"],
        finish: json["finish"],
        tilesPerBox: json["tiles_per_box"],
        sqmtrPerBox: json["sqmtr_per_box"],
        sqftPerBox: json["sqft_per_box"],
        price: json["price"],
        mrp: json["mrp"],
        productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
        category: json["category"],
        batch: List<Batch>.from(json["batch"].map((x) => Batch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "product_name": productName,
        "size": size,
        "body": body,
        "finish": finish,
        "tiles_per_box": tilesPerBox,
        "sqmtr_per_box": sqmtrPerBox,
        "sqft_per_box": sqftPerBox,
        "price": price,
        "mrp": mrp,
        "product_images": List<dynamic>.from(productImages!.map((x) => x.toJson())),
        "category": category,
        "batch": List<dynamic>.from(batch!.map((x) => x.toJson())),
    };
}

class Batch {
    Batch({
        this.batchId,
        this.batchCode,
        this.stock,
    });

    dynamic batchId;
    dynamic batchCode;
    dynamic stock;

    factory Batch.fromJson(Map<dynamic, dynamic> json) => Batch(
        batchId: json["batch_id"],
        batchCode: json["batch_code"],
        stock: json["stock"],
    );

    Map<dynamic, dynamic> toJson() => {
        "batch_id": batchId,
        "batch_code": batchCode,
        "stock": stock,
    };
}

class ProductImage {
    ProductImage({
        this.image,
    });

    String? image;

    factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
    };
}
