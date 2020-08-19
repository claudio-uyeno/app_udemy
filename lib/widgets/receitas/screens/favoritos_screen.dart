import 'package:flutter/material.dart';

import '../../../models/prato.dart';
import '../prato_item.dart';
import './categoria_receitas_screen.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Prato> _favoritos;

  FavoritosScreen(this._favoritos);

  @override
  Widget build(BuildContext context) {
    if (_favoritos.isEmpty) {
      return Center(child: Text('Lista de favoritos vazia!'));
    } else {
      return ListView.builder(
        itemBuilder: (ctx, idx) {
          var prato = _favoritos[idx];
          return Card(
            child: PratoItem(
              id: prato.id,
              imageUrl: prato.imageUrl,
              titulo: prato.titulo,
              duracao: prato.duracao,
              complexidade: prato.complexidade,
              preco: prato.preco,
            ),
          );
        },
        itemCount: _favoritos.length,
      );
    }
  }
}
