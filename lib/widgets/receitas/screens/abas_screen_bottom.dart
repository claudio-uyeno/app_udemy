import 'package:flutter/material.dart';

import 'categorias_screen.dart';
import 'favoritos_screen.dart';
import '../menu_lateral.dart';
import '../../../models/prato.dart';

class AbasScreenBottom extends StatefulWidget {
  final List<Prato> _favoritos;

  AbasScreenBottom(this._favoritos);

  @override
  State<StatefulWidget> createState() {
    return _AbasScreenBottomState();
  }
}

class _AbasScreenBottomState extends State<AbasScreenBottom> {
  List<Map<String, Object>> _paginas;
  int _idPaginaSelecionada;

  @override
  void initState() {
    _paginas = [
      {'titulo': 'Categorias', 'item': CategoriasScreen()},
      {'titulo': 'Favoritos', 'item': FavoritosScreen(widget._favoritos)}
    ];
    _idPaginaSelecionada = 0;
    super.initState();
  }

  void _selecionarPagina(int index) {
    setState(() {
      _idPaginaSelecionada = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_paginas[_idPaginaSelecionada]['titulo']),
      ),
      drawer: MenuLateral(),
      body: _paginas[_idPaginaSelecionada]['item'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _idPaginaSelecionada,
        onTap: _selecionarPagina,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categorias'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favoritos'),
          )
        ],
      ),
    );
  }
}
