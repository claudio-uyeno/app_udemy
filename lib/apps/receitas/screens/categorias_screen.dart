import 'package:flutter/material.dart';

import '../../../fake/categorias_fake.dart';
import '../categoria_item.dart';

class CategoriasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children:
          CATEGORIAS_FAKE.map((x) => CategoriaItem(x.id, x.titulo, x.cor)).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2, //proporção
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
    );
  }
}
