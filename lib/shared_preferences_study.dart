/*
 * @LastEditors: hezeying@xdf.cn
 * @Date: 2025-03-22 17:27:58
 * @LastEditTime: 2025-03-22 17:45:27
 * @FilePath: /flutter_net_storage/lib/shared_preferences_study.dart
 * @Description: 基于 SharedPreferences 的计数器
 */
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPCounterWidget extends StatefulWidget {
  const SPCounterWidget({super.key});

  @override
  State<SPCounterWidget> createState() => _SPCounterWidgetState();
}

class _SPCounterWidgetState extends State<SPCounterWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences 计数器'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter'),
            ElevatedButton(
                onPressed: _incrementCounter, child: const Text('加1')),
            ElevatedButton(
                onPressed: _decrementCounter, child: const Text('减1')),
          ],
        ),
      ),
    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
    });
    await prefs.setInt('counter', _counter);
  }

  _decrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) - 1;
    });
    await prefs.setInt('counter', _counter);
  }

  _initCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  // 初始化计数器
  @override
  void initState() {
    super.initState();
    _initCounter();
  }
}
