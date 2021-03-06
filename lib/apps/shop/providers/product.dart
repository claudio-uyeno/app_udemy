import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token, String userId) async{
    final url = 'https://sandbox-b766c.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    var oldValue = this.isFavorite;

    this.isFavorite = !this.isFavorite;
    notifyListeners();

    try{
      final response = await http.put(url, body: json.encode(this.isFavorite));

      if (response.statusCode >= 400){
        _setIsFavorite(oldValue);
      }
      
    } catch(error){
      _setIsFavorite(oldValue);
    }
  }

  void _setIsFavorite(bool value){
    this.isFavorite = value;
    notifyListeners();
  }

  Product copy(String id) {
    return Product(
        id: id,
        title: this.title,
        description: this.description,
        price: this.price,
        imageUrl: this.imageUrl,
        isFavorite: this.isFavorite);
  }
}
