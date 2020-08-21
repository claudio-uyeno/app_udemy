import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget{
  static const String route_name = '/product_detail';



  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold();
  }

}