import 'package:flutter/material.dart';

import './screens/filtros_screen.dart';

class MenuLateral extends StatelessWidget {
  Widget _opcoesBuilder(String titulo, IconData icone, Function onClick) {
    return ListTile(
      leading: Icon(
        icone,
        size: 26,
      ),
      title: Text(
        titulo,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: onClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            child: Text(
              'Opções',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _opcoesBuilder('Pratos', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          _opcoesBuilder('Filtros', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltrosScreen.routeName);
          }),
        ],
      ),
    );
  }
}
