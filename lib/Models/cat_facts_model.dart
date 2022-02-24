// To parse this JSON data, do
//
//     final catFactsModel = catFactsModelFromJson(jsonString);

import 'dart:convert';

CatFactsModel catFactsModelFromJson(String str) =>
    CatFactsModel.fromJson(json.decode(str));

String catFactsModelToJson(CatFactsModel data) => json.encode(data.toJson());

class CatFactsModel {
  CatFactsModel({
    this.fact,
    this.length,
  });

  String fact;
  int length;

  factory CatFactsModel.fromJson(Map<String, dynamic> json) => CatFactsModel(
        fact: json["fact"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "fact": fact,
        "length": length,
      };
}
