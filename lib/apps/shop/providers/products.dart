import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> addProductSync(Product product) {
    const url = 'https://sandbox-b766c.firebaseio.com/products.json';
    return http
        .post(url,
            body: json.encode({
              'id': product.id,
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavorite': product.isFavorite
            }))
        .then((response) {
      print(json.decode(response.body));
      _items.add(product.copy(json.decode(response.body)['name']));
      notifyListeners(); //notificas todos os widgets com listener
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://sandbox-b766c.firebaseio.com/products.json';

    try {
      final response = await http.post(url,
          body: json.encode({
            'id': product.id,
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite
          }));

      _items.add(product.copy(json.decode(response.body)['name']));
      
      notifyListeners(); //notificas todos os widgets com listener
    } catch (error) {
      throw error;
    }
  }

  Product getById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  void updateProduct(Product newProduct) {
    var index = _items.indexWhere((p) => p.id == newProduct.id);
    _items[index] = newProduct;
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
