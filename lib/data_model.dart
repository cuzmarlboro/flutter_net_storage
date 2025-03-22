import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  int code;
  Data data;
  String msg;

  DataModel({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "msg": msg,
      };
}

class Data {
  int code;
  String method;
  String requestPrams;

  Data({
    required this.code,
    required this.method,
    required this.requestPrams,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
        method: json["method"],
        requestPrams: json["requestPrams"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "method": method,
        "requestPrams": requestPrams,
      };
}
