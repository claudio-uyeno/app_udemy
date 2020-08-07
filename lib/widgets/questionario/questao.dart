import 'package:flutter/material.dart';

class Questao extends StatelessWidget {
  final String questaoTexto;

  Questao(this.questaoTexto);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      child: Text(
        questaoTexto,
        style: TextStyle(
          fontSize: 28,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
