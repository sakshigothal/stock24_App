// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
    DashboardModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
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
        this.marketingPersonsCount,
        this.dealersCount,
        this.subdealersCount,
        this.productsCount,
    });

    int? marketingPersonsCount;
    int? dealersCount;
    int? subdealersCount;
    int? productsCount;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        marketingPersonsCount: json["marketing_persons_count"],
        dealersCount: json["dealers_count"],
        subdealersCount: json["subdealers_count"],
        productsCount: json["products_count"],
    );

    Map<String, dynamic> toJson() => {
        "marketing_persons_count": marketingPersonsCount,
        "dealers_count": dealersCount,
        "subdealers_count": subdealersCount,
        "products_count": productsCount,
    };
}
