import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// 通过在文件输入快捷指令 stf 创建状态的 Widget
class HttpStudy extends StatefulWidget {
  const HttpStudy({super.key});

  @override
  State<HttpStudy> createState() => _HttpStudyState();
}

class _HttpStudyState extends State<HttpStudy> {
  var resultShow = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("基于 Http 实现网络操作"),
      ),
      body: Column(
        children: [
          _doGetBtn(),
          _doPostBtn(),
          _doPostJsonBtn(),
          Text("返回的结果: $resultShow")
        ],
      ),
    );
  }

  _doGetBtn() {
    return ElevatedButton(onPressed: _doGet, child: const Text("发送get请求"));
  }

  _doPostBtn() {
    return ElevatedButton(onPressed: _doPost, child: const Text("发送post请求"));
  }

  _doPostJsonBtn() {
    return ElevatedButton(
        onPressed: _doPostJson, child: const Text("发送json格式的post请求"));
  }

  /// 发送 get 请求
  void _doGet() async {
    var uri =
        Uri.parse('https://api.geekailab.com/uapi/test/test?requestPrams=11');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        resultShow = response.body;
      });
    } else {
      setState(() {
        resultShow = "请求失败: code:${response.statusCode} body:${response.body}";
      });
    }
  }

  /// 发送 post 请求
  void _doPost() async {
    var uri =
        Uri.parse('https://api.geekailab.com/uapi/test/test?requestPrams=11');
    var body = {"requestParams": "111"}; // 数据格式要求是Map<String,String>
    var response =
        await http.post(uri, body: body); // 默认为x-www-form-urlencoded 格式
    if (response.statusCode == 200) {
      setState(() {
        resultShow = response.body;
      });
    } else {
      setState(() {
        resultShow = "请求失败: code:${response.statusCode} body:${response.body}";
      });
    }
  }

  /// 发送Json类型的 post 请求
  void _doPostJson() async {
    var uri = Uri.parse('https://api.geekailab.com/uapi/test/testJson');
    var params = {"requestPrams": "doPost"};
    var response = await http.post(uri,
        body: jsonEncode(params),
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        resultShow =
            response.body; // response.body 是一个 Json 字符串，转成 Map 需要用到 jsonDecode
      });
      var map = jsonDecode(response.body);
    } else {
      setState(() {
        resultShow = "请求失败：code: ${response.statusCode}，body:${response.body}";
      });
    }
  }
}
