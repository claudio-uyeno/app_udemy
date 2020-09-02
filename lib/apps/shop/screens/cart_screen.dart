import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart'
    show
        Cart; //não carrega a class CartItem que tem o mesmo nome no widget cart_item
import '../widgets/cart_item.dart'
    as w; //utilizar um alias também resolve o problema

class CartScreen extends StatelessWidget {
  static const String route_name = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      'R\$ ${cartData.totalAmount}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      'Order now',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items.length,
              itemBuilder: (ctx, i) {
                var item = cartData.items.values.toList()[i];
                return w.CartItem(
                  id: item.id,
                  productId: cartData.items.keys.toList()[i],
                  title: item.title,
                  price: item.price,
                  quantity: item.quantity,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
