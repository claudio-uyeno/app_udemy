import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final Function responder;
  final String opcao;

  Resposta(this.responder, this.opcao);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(opcao),
        onPressed: responder,
      ),
    );
  }
}
