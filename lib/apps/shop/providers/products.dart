import 'package:flutter/material.dart';

import 'product.dart';
import '../../../fake/products_fake.dart';

class Products with ChangeNotifier {
  List<Product> _items = PRODUCTS_FAKE;

  List<Product> get items {
    return [..._items]; //[xxx]retorna uma cópia
  }

  List<Product> get favoriteItems {
    return _items.where((x) => x.isFavorite).toList();
  }

  void addProduct(Product value){
    _items.add(value);
    notifyListeners();  //notificas todos os widgets com listener
  }

  Product getById(String id){
    return _items.firstWhere((p) => p.id == id);
  }
}