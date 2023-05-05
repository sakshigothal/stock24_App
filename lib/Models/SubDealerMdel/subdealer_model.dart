// To parse this JSON data, do
//
//     final subDealerModel = subDealerModelFromJson(jsonString);

import 'dart:convert';

SubDealerModel subDealerModelFromJson(String str) => SubDealerModel.fromJson(json.decode(str));

String subDealerModelToJson(SubDealerModel data) => json.encode(data.toJson());

class SubDealerModel {
    SubDealerModel({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory SubDealerModel.fromJson(Map<String, dynamic> json) => SubDealerModel(
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
        this.firm,
        this.contactPerson,
        this.mobileNumber,
        this.whatsappNumber,
        this.pincode,
        this.area,
        this.frontSide,
        this.frontSidePath,
        this.backSide,
        this.backSidePath,
        this.dealer,
    });

    int? id;
    String? firm;
    String? contactPerson;
    String? mobileNumber;
    String? whatsappNumber;
    String? pincode;
    String? area;
    String? frontSide;
    String? frontSidePath;
    String? backSide;
    String? backSidePath;
    List<Dealer>? dealer;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        firm: json["firm"],
        contactPerson: json["contact_person"],
        mobileNumber: json["mobile_number"],
        whatsappNumber: json["whatsapp_number"],
        pincode: json["pincode"],
        area: json["area"],
        frontSide: json["front_side"],
        frontSidePath: json["front_side_path"],
        backSide: json["back_side"],
        backSidePath: json["back_side_path"],
        dealer: List<Dealer>.from(json["dealer"].map((x) => Dealer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firm": firm,
        "contact_person": contactPerson,
        "mobile_number": mobileNumber,
        "whatsapp_number": whatsappNumber,
        "pincode": pincode,
        "area": area,
        "front_side": frontSide,
        "front_side_path": frontSidePath,
        "back_side": backSide,
        "back_side_path": backSidePath,
        "dealer": List<dynamic>.from(dealer!.map((x) => x.toJson())),
    };
}

class Dealer {
    Dealer({
        this.id,
        this.name,
    });

    int? id;
    Name? name;

    factory Dealer.fromJson(Map<String, dynamic> json) => Dealer(
        id: json["id"],
        name: nameValues.map[json["name"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
    };
}

enum Name { AVANTECH_TECHNOLOGIES, DSUZA }

final nameValues = EnumValues({
    "Avantech Technologies": Name.AVANTECH_TECHNOLOGIES,
    "Dsuza": Name.DSUZA
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap;
        return reverseMap!;
    }
}
