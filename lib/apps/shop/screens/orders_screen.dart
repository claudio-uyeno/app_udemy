import 'package:app_udemy/apps/shop/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatefulWidget {
  static const route_name = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // var _isLoading = false;

  // @override  //v1
  // void initState() {
  //   Future.delayed(Duration.zero).then((_) async {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     await Provider.of<Orders>(context, listen: false).fetchOrders();

  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  // @override  //v2
  // void initState() {
  //   _isLoading = true;

  //   Provider.of<Orders>(context, listen: false).fetchOrders().then((_) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });

  //   super.initState();
  // }
  Future _futureOders;

  @override
  void initState() {
    _futureOders = _getFutureOrders();

    super.initState();
  }

  Future _getFutureOrders() { //garante que só será executado uma vez, e não a cada renderização da tela.
    return Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context); //v1_v2

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _futureOders,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(child: Text('Error while fetching orders!'));
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, idx) => OrderItem(orderData.orders[idx]),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
      // _isLoading //v1_v2
      //     ? Center(child: CircularProgressIndicator())
      //     : ListView.builder(
      //         itemBuilder: (ctx, idx) => OrderItem(orderData.orders[idx]),
      //         itemCount: orderData.orders.length,
      //       ),
    );
  }
}
