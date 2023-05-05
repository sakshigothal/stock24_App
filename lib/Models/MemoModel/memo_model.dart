// To parse this JSON data, do
//
//     final memoModel = memoModelFromJson(jsonString);

import 'dart:convert';

MemoModel memoModelFromJson(String str) => MemoModel.fromJson(json.decode(str));

String memoModelToJson(MemoModel data) => json.encode(data.toJson());

class MemoModel {
  MemoModel({
    this.success,
    this.message,
    this.data,
  });

  String? success;
  String? message;
  Data? data;

  factory MemoModel.fromJson(Map<String, dynamic> json) => MemoModel(
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

  List<MemoResult>? result;
  int? totalRecords;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: List<MemoResult>.from(json["result"].map((x) => MemoResult.fromJson(x))),
    totalRecords: json["total_records"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "total_records": totalRecords,
  };
}

class MemoResult {
  MemoResult({
    this.id,
    this.companyId,
    this.companyName,
    this.createdBy,
    this.createdByName,
    this.createdAt,
    this.category,
    this.sampleData,
    this.totalPcs,
  });

  int? id;
  String? companyId;
  String? companyName;
  String? createdBy;
  String? createdByName;
  String? createdAt;
  List<Category>? category;
  List<SampleDatum>? sampleData;
  int? totalPcs;

  factory MemoResult.fromJson(Map<String, dynamic> json) => MemoResult(
    id: json["id"],
    companyId: json["company_id"],
    companyName: json["company_name"],
    createdBy: json["created_by"],
    createdByName: json["created_by_name"],
    createdAt: json["created_at"],
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    sampleData: List<SampleDatum>.from(json["sample_data"].map((x) => SampleDatum.fromJson(x))),
    totalPcs: json["total_pcs"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "company_name": companyName,
    "created_by": createdBy,
    "created_by_name": createdByName,
    "created_at": createdAt,
    "category": List<dynamic>.from(category!.map((x) => x.toJson())),
    "sample_data": List<dynamic>.from(sampleData!.map((x) => x.toJson())),
    "total_pcs": totalPcs,
  };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
  });

  int? categoryId;
  String? categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
  };
}

class SampleDatum {
  SampleDatum({
    this.productId,
    this.productName,
    this.size,
    this.qty,
  });

  String? productId;
  String? productName;
  String? size;
  String? qty;

  factory SampleDatum.fromJson(Map<String, dynamic> json) => SampleDatum(
    productId: json["product_id"],
    productName: json["product_name"],
    size: json["size"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "size": size,
    "qty": qty,
  };
}
