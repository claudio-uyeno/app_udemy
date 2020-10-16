import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

class AppShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders())
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          primaryColor: Colors.cyan,
          accentColor: Colors.yellowAccent,
          fontFamily: 'Lato',
        ),
        home: AuthScreen(), //ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.route_name: (ctx) => ProductDetailScreen(),
          CartScreen.route_name: (ctx) => CartScreen(),
          OrderScreen.route_name: (ctx) => OrderScreen(),
          UserProductsScreen.route_name: (ctx) => UserProductsScreen(),
          EditProductScreen.rout_name: (ctx) => EditProductScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
        },
      ),
    );
  }
}
