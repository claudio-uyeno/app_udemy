import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int total;
  final Function reset;

  Resultado(this.total, this.reset);

  String get mensagem {
    if (total <= 3) {
      return 'Categoria 1';
    } else if (total < 6) {
      return 'Categoria 2';
    } else {
      return 'Categoria 3';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          mensagem,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          child: Text(
            'Reiniciar',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: reset,
        ),
      ],
    ));
  }
}
