import 'package:flutter/material.dart';

import '../../../fake/pratos_fake.dart';
import '../prato_item.dart';

class CategoriaReceitasScreen extends StatelessWidget {
  static const routeName = '/categoria-pratos';
  //obsoleto ao implementar rotas
  // final String id;
  // final String titulo;
  // CategoriaReceitasScreen(this.id, this.titulo);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final id = routeArgs['id'];
    final titulo = routeArgs['titulo'];
    final pratosPorCategoria = PRATOS_FAKE.where((prato) {
      return prato.categorias.contains(id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          var prato = pratosPorCategoria[idx];
          return Card(
            child: PratoItem(imageUrl: prato.imageUrl,),
          );
        },
        itemCount: pratosPorCategoria.length,
      ),
    );
  }
}
