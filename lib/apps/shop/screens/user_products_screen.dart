import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const String route_name = '/user-products';

  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.rout_name);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: productsData.items.length,
        itemBuilder: (_, i) => UserProductItem(
          productsData.items[i].title,
          productsData.items[i].imageUrl,
        ),
      ),
    );
  }
}
