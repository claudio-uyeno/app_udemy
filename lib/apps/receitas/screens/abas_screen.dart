import 'package:flutter/material.dart';

import './categorias_screen.dart';
import './favoritos_screen.dart';
import '../../../models/prato.dart';

class AbasScreen extends StatefulWidget {
  final List<Prato> _favoritos;

  AbasScreen(this._favoritos);

  @override
  State<StatefulWidget> createState() {
    return _AbasScreenState();
  }
}

class _AbasScreenState extends State<AbasScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Receitas'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categorias',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favoritos',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [CategoriasScreen(), FavoritosScreen(widget._favoritos)],
        ),
      ),
    );
  }
}
