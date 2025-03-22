import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_model.dart';

/// Json 解析与 Dart Model 的使用
class JsonParsing extends StatefulWidget {
  const JsonParsing({super.key});

  @override
  State<JsonParsing> createState() => _JsonParsingState();
}

class _JsonParsingState extends State<JsonParsing> {
  var resultShow = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json 解析与 Dart Model 的使用"),
      ),
      body: Column(
        children: [_json2MapBtn(), _json2MapModelBtn(), new Text(resultShow)],
      ),
    );
  }

  _json2MapBtn() {
    return ElevatedButton(onPressed: _json2Map, child: const Text('json转map'));
  }

  _json2MapModelBtn() {
    return ElevatedButton(
        onPressed: _json2Model, child: const Text('json转map model'));
  }

  /// json 转 map
  void _json2Map() {
    var jsonString =
        '{"code":0,"data":{"code":0,"method":"GET","requestPrams":"11"},"msg":"SUCCESS."}';
    Map<String, dynamic> map = jsonDecode(jsonString); //将json转成Map；
    setState(() {
      resultShow =
          'code: ${map['code']};requestPrams:${map['data']['requestPrams']}'; //使用Map中的数据
    });
  }

  //json转Model
  void _json2Model() {
    var jsonString =
        '{"code":0,"data":{"code":0,"method":"GET","requestPrams":"11"},"msg":"SUCCESS."}';
    Map<String, dynamic> map = jsonDecode(jsonString); // 将 json 转成 Map；
    DataModel model = DataModel.fromJson(map); // 将 Map 转成 Dart Model
    setState(() {
      resultShow =
          'code: ${model.code};requestPrams:${model.data?.requestPrams}'; //使用Map中的数据
    });
  }
}
