// To parse this JSON data, do
//
//     final allLines = allLinesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllLines> allLinesFromJson(String str) => List<AllLines>.from(json.decode(str).map((x) => AllLines.fromJson(x)));

String allLinesToJson(List<AllLines> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllLines {
  AllLines({
    required this.admin,
    required this.city,
    required this.count,
    required this.id,
    required this.isActive,
    required this.name,
    required this.tag,
    required this.timePerUserM,
    required this.totalTime,
    required this.users,
  });

  dynamic admin;
  dynamic city;
  dynamic count;
  dynamic id;
  dynamic isActive;
  dynamic name;
  dynamic tag;
  dynamic timePerUserM;
  dynamic totalTime;
  List<dynamic> users;

  factory AllLines.fromJson(Map<String, dynamic> json) => AllLines(
    admin: json["admin"],
    city: json["city"],
    count: json["count"],
    id: json["id"],
    isActive: json["is_active"],
    name: json["name"],
    tag: json["tag"],
    timePerUserM: json["time_per_user_m"],
    totalTime: json["total_time"],
    users: List<dynamic>.from(json["users"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "admin": admin,
    "city": city,
    "count": count,
    "id": id,
    "is_active": isActive,
    "name": name,
    "tag": tag,
    "time_per_user_m": timePerUserM,
    "total_time": totalTime,
    "users": List<dynamic>.from(users.map((x) => x)),
  };
}
