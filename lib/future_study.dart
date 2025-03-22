/*
 * @LastEditors: hezeying@xdf.cn
 * @Date: 2025-03-22 16:55:40
 * @LastEditTime: 2025-03-22 17:17:01
 * @FilePath: /flutter_net_storage/lib/future_study.dart
 * @Description: Future 和 FutureBuilder 的使用
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data_model.dart';

class FutureStudy extends StatefulWidget {
  const FutureStudy({super.key});

  // 重写 createState 方法，返回一个 _FutureStudyState 对象。
  @override
  State<FutureStudy> createState() => _FutureStudyState();
}

// _FutureStudyState 是 FutureStudy 组件的 State 类，用于管理组件的状态。
class _FutureStudyState extends State<FutureStudy> {
  @override
  Widget build(BuildContext context) {
    // Scaffold 是 Flutter 中的一个组件，用于创建一个包含应用栏（AppBar）和主体内容（Body）的页面。
    return Scaffold(
      // appBar 是 Scaffold 组件的一个属性，用于设置应用栏（AppBar）。
      appBar: AppBar(
        title: const Text("Future 和 FutureBuilder 的使用"),
      ),
      // FutureBuilder 是 Flutter 中的一个组件，用于在异步操作完成后显示结果。
      body: FutureBuilder<DataModel>(
        // 异步操作
        future: fetchGet(),
        // 异步操作完成后，显示结果
        builder: (BuildContext context, AsyncSnapshot<DataModel> snapshot) {
          // context 是 BuildContext 类型，用于存储当前上下文。
          // snapshot 是 FutureBuilder 组件的一个属性，用于存储异步操作的结果。

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("没有连接");
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return const Text("连接活动中");
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text("错误: ${snapshot.error}");
              } else {
                return Column(
                  children: [
                    Text("code: ${snapshot.data?.code}"),
                    Text("requestPrams: ${snapshot.data?.data.requestPrams}"),
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Future<DataModel> fetchGet() async {
    var uri =
        Uri.parse("https://api.geekailab.com/uapi/test/test?requestPrams=11");

    final response = await http.get(uri);
    return DataModel.fromJson(jsonDecode(response.body));
  }
}
