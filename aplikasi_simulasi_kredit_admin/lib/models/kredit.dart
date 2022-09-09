import 'package:aplikasi_simulasi_kredit_admin/models/instalment.dart';

// To parse this JSON data, do
//
//     final kreditModel = kreditModelFromJson(jsonString);

import 'dart:convert';

KreditModel kreditModelFromJson(String str) =>
    KreditModel.fromJson(json.decode(str));

String kreditModelToJson(KreditModel data) => json.encode(data.toJson());

class KreditModel {
  KreditModel(
      {this.userId,
      required this.interestLoan,
      required this.instalment,
      required this.startMonth,
      required this.totalLoan,
      required this.startYear,
      required this.interestType,
      required this.loanDate,
      required this.durationLoan,
      this.instalments,
      required this.createdDate,
      required this.status});

  String? userId;
  double interestLoan;
  String instalment;
  String startMonth;
  double totalLoan;
  int startYear;
  String interestType;
  String loanDate;
  int durationLoan;
  List<Instalment>? instalments;
  int createdDate;
  String status;
  String? id;
  
  factory KreditModel.fromJson(Map<String, dynamic> json) => KreditModel(
      userId: json["userId"],
      interestLoan: json["interestLoan"],
      instalment: json["instalment"],
      startMonth: json["startMonth"],
      totalLoan: json["totalLoan"],
      startYear: json["startYear"],
      interestType: json["interestType"],
      loanDate: json["loanDate"],
      durationLoan: json["durationLoan"],
      instalments: List<Instalment>.from(
          json["instalments"].map((x) => Instalment.fromJson(x))),
      createdDate: json["createdDate"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "interestLoan": interestLoan,
        "instalment": instalment,
        "startMonth": startMonth,
        "totalLoan": totalLoan,
        "startYear": startYear,
        "interestType": interestType,
        "loanDate": loanDate,
        "durationLoan": durationLoan,
        "instalments": instalments != null
            ? List<dynamic>.from(instalments!.map((x) => x.toJson()))
            : [],
        "createdDate": createdDate,
        "status": status
      };
}
