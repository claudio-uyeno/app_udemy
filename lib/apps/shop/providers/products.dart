import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';
import '../../../fake/products_fake.dart';
import '../models/http_exception.dart';

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

  Future<void> updateProduct(Product product) async {
    final url =
        'https://sandbox-b766c.firebaseio.com/products/${product.id}.json';

    try {
      http.patch(url,
          body: json.encode({
            'id': product.id,
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
    } catch (error) {
      throw error;
    }

    var index = _items.indexWhere((p) => p.id == product.id);
    _items[index] = product;
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    var url = 'https://sandbox-b766c.firebaseio.com/products/$id';
    final existingProductIndex = _items.indexWhere((p) => p.id == id);
    var existingProduct = _items[
        existingProductIndex]; //bkp em memória para 'optimistic updating' garante que se der erro, faz 'rollback'

    final response = await http.delete(url);

    _items.removeAt(existingProductIndex);
    notifyListeners();

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }

    existingProduct = null;
  }

  Future<void> fetchProducts() async {
    const url = 'https://sandbox-b766c.firebaseio.com/products.json';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data != null) {
        final products = List<Product>();

        data.forEach((productId, productData) {
          if (!_items.any((p) => p.id == productId)) {
            final prod = Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              imageUrl: productData['imageUrl'],
              price: productData['price'],
              isFavorite: productData['isFavorite'],
            );
            products.add(prod);
          }
        });
        _items.addAll(products);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
