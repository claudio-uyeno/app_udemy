import 'package:flutter/foundation.dart';

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

  void toggleFavorite() {
    this.isFavorite = !this.isFavorite;
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
