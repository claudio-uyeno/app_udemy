import 'package:app_udemy/apps/shop/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
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
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products('', '', []),
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Shop',
          theme: ThemeData(
            primaryColor: Colors.cyan,
            accentColor: Colors.yellowAccent,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : FutureBuilder(future: auth.tryAutoLogin(), builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),) ,
          routes: {
            ProductDetailScreen.route_name: (ctx) => ProductDetailScreen(),
            CartScreen.route_name: (ctx) => CartScreen(),
            OrderScreen.route_name: (ctx) => OrderScreen(),
            UserProductsScreen.route_name: (ctx) => UserProductsScreen(),
            EditProductScreen.rout_name: (ctx) => EditProductScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
