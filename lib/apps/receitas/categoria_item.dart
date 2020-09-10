import 'package:flutter/material.dart';

import 'screens/categoria_receitas_screen.dart';

class CategoriaItem extends StatelessWidget {
  final String id;
  final String titulo;
  final Color cor;

  CategoriaItem(this.id, this.titulo, this.cor);

  void _selecionarCategoria(BuildContext ctx) {
    //obsolete - rota implementada
    // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    //   return CategoriaReceitasScreen(id, titulo);
    // }));

    //Navigator.of(ctx).pushNamed('/categoria-pratos', arguments: {'id': id, 'titulo': titulo});
    Navigator.of(ctx).pushNamed(CategoriaReceitasScreen.routeName, arguments: {'id': id, 'titulo': titulo});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selecionarCategoria(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          titulo,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cor.withOpacity(0.7),
              cor, //cor = cor.witOpacity(1.0)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
