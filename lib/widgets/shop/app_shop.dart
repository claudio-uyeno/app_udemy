import 'package:flutter/material.dart';

class AppShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shop'),
        ),
        body: Center(child: Text('Loading ...'),),
      ),
    );
  }
}
