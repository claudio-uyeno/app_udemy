import 'package:flutter/material.dart';

import 'categorias_screen.dart';
import 'favoritos_screen.dart';
import '../menu_lateral.dart';

class AbasScreenBottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AbasScreenBottomState();
  }
}

class _AbasScreenBottomState extends State<AbasScreenBottom> {
  final List<Map<String, Object>> _paginas = [
    {'titulo': 'Categorias', 'item': CategoriasScreen()},
    {'titulo': 'Favoritos', 'item': FavoritosScreen()}
  ];
  int _idPaginaSelecionada = 0;

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
