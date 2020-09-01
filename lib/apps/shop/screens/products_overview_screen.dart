import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions filter) {
              setState(() {                
                _showFavorites = (filter == FilterOptions.Favorites);
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Favorites'), value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('All'), value: FilterOptions.All),
            ],
          )
        ],
      ),
      body: ProductsGrid(_showFavorites),
    );
  }
}

enum FilterOptions {
  All,
  Favorites
}