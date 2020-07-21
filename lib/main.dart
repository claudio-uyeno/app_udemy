import 'package:flutter/material.dart';

void main() {
  runApp(AppUdemy());
}

class AppUdemy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppUdemyState();
  }
}

class _AppUdemyState extends State<AppUdemy> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
      ),
    );
  }
}
