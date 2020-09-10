import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('R\$ ${widget.order.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              Container(
                  height: min(widget.order.products.length * 20.0 + 10, 100),
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: widget.order.products.length,
                    itemBuilder: (ctx, idx) => Row(
                      children: [
                        Text(
                          widget.order.products[idx].title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            'R\$ ${widget.order.products[idx].price} x ${widget.order.products[idx].quantity}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  )),
          ],
        ));
  }
}
