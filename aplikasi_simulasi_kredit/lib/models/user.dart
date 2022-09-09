// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.address,
    required this.birth,
    required this.company,
    required this.name,
    required this.nik,
    required this.password,
    required this.phone,
    required this.username,
  });

  String address;
  String birth;
  String company;
  String name;
  String nik;
  String password;
  String phone;
  String username;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        address: json["address"],
        birth: json["birth"],
        company: json["company"],
        name: json["name"],
        nik: json["nik"],
        password: json["password"],
        phone: json["phone"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "birth": birth,
        "company": company,
        "name": name,
        "nik": nik,
        "password": password,
        "phone": phone,
        "username": username,
      };
}
