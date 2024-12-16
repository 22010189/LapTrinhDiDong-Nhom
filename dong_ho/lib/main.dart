import 'package:flutter/material.dart';
import 'dart:async'; // Thư viện hỗ trợ Timer

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClockApp(),
    );
  }
}

class ClockApp extends StatefulWidget {
  @override
  _ClockAppState createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime(); // Gọi cập nhật thời gian lần đầu
    Timer.periodic(Duration(seconds: 1), (timer) => _updateTime()); // Cập nhật mỗi giây
  }

  void _updateTime() {
    final now = DateTime.now(); // Lấy thời gian hiện tại
    setState(() {
      _currentTime = '${_formatTime(now.hour)}:${_formatTime(now.minute)}:${_formatTime(now.second)}';
    });
  }

  String _formatTime(int value) {
    return value.toString().padLeft(2, '0'); // Định dạng 2 chữ số, thêm '0' nếu cần
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clock App'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          _currentTime,
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            fontFamily: 'Courier',
          ),
        ),
      ),
    );
  }
}
