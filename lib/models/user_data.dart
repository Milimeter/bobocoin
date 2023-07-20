// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  UserData? data;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        status: json["status"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class UserData {
  UserData({
    this.id,
    this.fullname,
    this.email,
    this.phone,
    this.mnemonics,
    this.password,
    this.country,
    this.countrycode,
    this.v,
  });

  String? id;
  String? fullname;
  String? email;
  String? phone;
  String? mnemonics;
  String? password;
  String? country;
  String? countrycode;
  int? v;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"] ?? '',
        fullname: json["fullname"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        mnemonics: json["mnemonics"] ?? '',
        password: json["password"] ?? '',
        country: json["country"] ?? '',
        countrycode: json["countrycode"] ?? '',
        v: json["__v"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "mnemonics": mnemonics,
        "password": password,
        "country": country,
        "countrycode": countrycode,
        "__v": v,
      };
}
