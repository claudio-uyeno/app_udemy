import 'package:flutter/material.dart';

class CategoriaItem extends StatelessWidget {
  final String titulo;
  final Color cor;

  CategoriaItem(this.titulo, this.cor);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
