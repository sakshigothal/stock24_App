// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
         this.success,
         this.message,
         this.data,
    });

    String? success;
    String? message;
    List<Datum>? data;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
         this.id,
         this.companyId,
         this.companyName,
         this.roleId,
         this.role,
         this.name,
         this.designation,
         this.area,
         this.mobileNumber,
         this.whatsappNumber,
         this.email,
         this.address,
         this.pincode,
         this.country,
         this.state,
         this.city,
         this.gstNo,
         this.panNo,
         this.bankName,
         this.accountType,
         this.accountNo,
         this.ifscCode,
         this.branch,
         this.frontSide,
         this.frontSidePath,
         this.backSide,
         this.backSidePath,
         this.status,
         this.createdBy,
         this.updatedBy,
         this.createdAt,
         this.updatedAt,
         this.token,
    });

    int? id;
    String? companyId;
    String? companyName;
    String? roleId;
    String? role;
    String? name;
    String? designation;
    String? area;
    String? mobileNumber;
    String? whatsappNumber;
    String? email;
    String? address;
    String? pincode;
    String? country;
    String? state;
    String? city;
    String? gstNo;
    String? panNo;
    String? bankName;
    String? accountType;
    String? accountNo;
    String? ifscCode;
    String? branch;
    String? frontSide;
    String? frontSidePath;
    String? backSide;
    String? backSidePath;
    String? status;
    String? createdBy;
    String? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? token;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        companyId: json["company_id"],
        companyName: json["company_name"],
        roleId: json["role_id"],
        role: json["role"],
        name: json["name"],
        designation: json["designation"],
        area: json["area"],
        mobileNumber: json["mobile_number"],
        whatsappNumber: json["whatsapp_number"],
        email: json["email"],
        address: json["address"],
        pincode: json["pincode"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        gstNo: json["gst_no"],
        panNo: json["pan_no"],
        bankName: json["bank_name"],
        accountType: json["account_type"],
        accountNo: json["account_no"],
        ifscCode: json["ifsc_code"],
        branch: json["branch"],
        frontSide: json["front_side"],
        frontSidePath: json["front_side_path"],
        backSide: json["back_side"],
        backSidePath: json["back_side_path"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "company_name": companyName,
        "role_id": roleId,
        "role": role,
        "name": name,
        "designation": designation,
        "area": area,
        "mobile_number": mobileNumber,
        "whatsapp_number": whatsappNumber,
        "email": email,
        "address": address,
        "pincode": pincode,
        "country": country,
        "state": state,
        "city": city,
        "gst_no": gstNo,
        "pan_no": panNo,
        "bank_name": bankName,
        "account_type": accountType,
        "account_no": accountNo,
        "ifsc_code": ifscCode,
        "branch": branch,
        "front_side": frontSide,
        "front_side_path": frontSidePath,
        "back_side": backSide,
        "back_side_path": backSidePath,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "token": token,
    };
}
