import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  String _token;
  String _userId;

  Orders(this._token, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> products, double total) async {
    final url = 'https://sandbox-b766c.firebaseio.com/orders/$_userId.json?auth=$_token';
    final orderDate = DateTime.now();

    try {
      var response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': orderDate.toIso8601String(),
            'products': products
                .map((p) => {
                      'id': p.id,
                      'title': p.title,
                      'quantity': p.quantity,
                      'price': p.price,
                    })
                .toList()
          }));

      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: products,
            dateTime: orderDate,
          )); //insert 0 inclui sempre no começo da lista
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchOrders() async {
    final url = 'https://sandbox-b766c.firebaseio.com/orders/$_userId.json?auth=$_token';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      var orders = List<OrderItem>();
      extractedData.forEach((orderId, orderData) {
        final order = OrderItem(
            id: orderId,
            dateTime: DateTime.parse(orderData['dateTime']),
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      price: item['price'],
                      quantity: item['quantity'],
                    ))
                .toList());

        orders.add(order);
      });

      _orders = orders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
