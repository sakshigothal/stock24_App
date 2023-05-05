// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
    this.id,
    this.type,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? key;
  String? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
    id: json["id"],
    type: json["type"],
    key: json["key"],
    value: json["value"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "key": key,
    "value": value,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
