// To parse this JSON data, do
//
//     final getDealer = getDealerFromJson(jsonString);

import 'dart:convert';

GetDealer getDealerFromJson(String str) => GetDealer.fromJson(json.decode(str));

String getDealerToJson(GetDealer data) => json.encode(data.toJson());

class GetDealer {
    GetDealer({
        this.success,
        this.message,
        this.data,
    });

    String? success;
    String? message;
    Data? data;

    factory GetDealer.fromJson(Map<String, dynamic> json) => GetDealer(
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
        this.email,
        this.gstNo,
        this.panNo,
        this.address,
        this.pincode,
        this.country,
        this.state,
        this.city,
        this.bankName,
        this.branch,
        this.accountType,
        this.accountNo,
        this.ifscCode,
        this.frontSide,
        this.frontSidePath,
        this.backSide,
        this.backSidePath,
        this.marketingPerson,
        this.marketingPersonName,
    });

    int? id;
    String? firm;
    String? contactPerson;
    String? mobileNumber;
    String? whatsappNumber;
    String? email;
    String? gstNo;
    String? panNo;
    String? address;
    String? pincode;
    String? country;
    String? state;
    String? city;
    String? bankName;
    String? branch;
    String? accountType;
    String? accountNo;
    String? ifscCode;
    String? frontSide;
    String? frontSidePath;
    String? backSide;
    String? backSidePath;
    String? marketingPerson;
    String? marketingPersonName;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        firm: json["firm"],
        contactPerson: json["contact_person"],
        mobileNumber: json["mobile_number"],
        whatsappNumber: json["whatsapp_number"],
        email: json["email"],
        gstNo: json["gst_no"],
        panNo: json["pan_no"],
        address: json["address"],
        pincode: json["pincode"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        bankName: json["bank_name"],
        branch: json["branch"],
        accountType: json["account_type"],
        accountNo: json["account_no"],
        ifscCode: json["ifsc_code"],
        frontSide: json["front_side"],
        frontSidePath: json["front_side_path"],
        backSide: json["back_side"],
        backSidePath: json["back_side_path"],
        marketingPerson: json["marketing_person"],
        marketingPersonName: json["marketing_person_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firm": firm,
        "contact_person": contactPerson,
        "mobile_number": mobileNumber,
        "whatsapp_number": whatsappNumber,
        "email": email,
        "gst_no": gstNo,
        "pan_no": panNo,
        "address": address,
        "pincode": pincode,
        "country": country,
        "state": state,
        "city": city,
        "bank_name": bankName,
        "branch": branch,
        "account_type": accountType,
        "account_no": accountNo,
        "ifsc_code": ifscCode,
        "front_side": frontSide,
        "front_side_path": frontSidePath,
        "back_side": backSide,
        "back_side_path": backSidePath,
        "marketing_person": marketingPerson,
        "marketing_person_name": marketingPersonName,
    };
}
