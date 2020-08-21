import 'package:flutter/material.dart';

import '../models/product.dart';
import '../../../fake/products_fake.dart';

class Products with ChangeNotifier {
  List<Product> _items = PRODUCTS_FAKE;

  List<Product> get items {
    return [..._items]; //[xxx]retorna uma cópia
  }

  void addProduct(Product value){
    _items.add(value);
    notifyListeners();  //notificas todos os widgets com listener
  }
}