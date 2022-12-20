/*
class MyProfile {
  late String sAttachments;
  late String sEtag;
  late String sRid;
  late String sSelf;
  late int iTs;
  late List<Activequeues> activequeues;
  late List<String> createdqueues;
  late String id;
  late int nactivequeues;
  late int ncreatedqueues;
  late String password;
  late int phone;

  MyProfile(
      {required this.sAttachments,
        required this.sEtag,
        required this.sRid,
        required this.sSelf,
        required this.iTs,
        required this.activequeues,
        required this.createdqueues,
        required this.id,
        required this.nactivequeues,
        required this.ncreatedqueues,
        required this.password,
        required this.phone});

  MyProfile.fromJson(Map<String, dynamic> json) {
    sAttachments = json['_attachments'];
    sEtag = json['_etag'];
    sRid = json['_rid'];
    sSelf = json['_self'];
    iTs = json['_ts'];
    if (json['activequeues'] != null) {
      activequeues = <Activequeues>[];
      json['activequeues'].forEach((v) {
        activequeues.add(new Activequeues.fromJson(v));
      });
    }
    createdqueues = json['createdqueues'];
    id = json['id'];
    nactivequeues = json['nactivequeues'];
    ncreatedqueues = json['ncreatedqueues'];
    password = json['password'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_attachments'] = this.sAttachments;
    data['_etag'] = this.sEtag;
    data['_rid'] = this.sRid;
    data['_self'] = this.sSelf;
    data['_ts'] = this.iTs;
    if (this.activequeues != null) {
      data['activequeues'] = this.activequeues.map((v) => v.toJson()).toList();
    }
    if (this.createdqueues != null) {
      data['createdqueues'] =
          this.createdqueues.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['nactivequeues'] = this.nactivequeues;
    data['ncreatedqueues'] = this.ncreatedqueues;
    data['password'] = this.password;
    data['phone'] = this.phone;
    return data;
  }
}

class Activequeues {
  late String city;
  late String id;
  late bool isActive;
  late String name;
  late int position;
  late String tag;
  late int time;

  Activequeues(
      {
        required this.city,
        required this.id,
        required this.isActive,
        required this.name,
        required this.position,
        required this.tag,
        required this.time});

  Activequeues.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    id = json['id'];
    isActive = json['is_active'];
    name = json['name'];
    position = json['position'];
    tag = json['tag'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['id'] = this.id;
    data['is_active'] = this.isActive;
    data['name'] = this.name;
    data['position'] = this.position;
    data['tag'] = this.tag;
    data['time'] = this.time;
    return data;
  }
}
*/
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// To parse this JSON data, do
//
//     final myProfile = myProfileFromJson(jsonString);

// To parse this JSON data, do
//
//     final myProfile = myProfileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyProfile myProfileFromJson(String str) => MyProfile.fromJson(json.decode(str));
String myProfileToJson(MyProfile data) => json.encode(data.toJson());

class MyProfile {
  MyProfile({
    required this.attachments,
    required this.etag,
    required this.rid,
    required this.self,
    required this.ts,
    required this.activequeues,
    required this.createdqueues,
    required this.id,
    required this.nactivequeues,
    required this.ncreatedqueues,
    required this.password,
    required this.phone,
  });

  String attachments;
  String etag;
  String rid;
  String self;
  int ts;
  List<dynamic> activequeues;
  List<dynamic> createdqueues;
  String id;
  int nactivequeues;
  int ncreatedqueues;
  String password;
  String phone;

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
    attachments: json["_attachments"],
    etag: json["_etag"],
    rid: json["_rid"],
    self: json["_self"],
    ts: json["_ts"],
    activequeues: List<dynamic>.from(json["activequeues"].map((x) => x)),
    createdqueues: List<dynamic>.from(json["createdqueues"].map((x) => x)),
    id: json["id"],
    nactivequeues: json["nactivequeues"],
    ncreatedqueues: json["ncreatedqueues"],
    password: json["password"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_attachments": attachments,
    "_etag": etag,
    "_rid": rid,
    "_self": self,
    "_ts": ts,
    "activequeues": List<dynamic>.from(activequeues.map((x) => x)),
    "createdqueues": List<dynamic>.from(createdqueues.map((x) => x)),
    "id": id,
    "nactivequeues": nactivequeues,
    "ncreatedqueues": ncreatedqueues,
    "password": password,
    "phone": phone,
  };
}
