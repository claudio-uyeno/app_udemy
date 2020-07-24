import 'package:flutter/material.dart';

import './transacao_lista.dart';
import './transacao_novo.dart';
import '../models/transacao.dart';

//obsolete
class TransacaoUsuario extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransacaoUsuario();
  }
}

class _TransacaoUsuario extends State<TransacaoUsuario> {
  final List<Transacao> _transacoes = [
    Transacao(
        id: 1, descricao: 'Tênis', valor: 99.99, data: DateTime(2020, 07, 01)),
    Transacao(
        id: 2,
        descricao: 'Notebook',
        valor: 2499.99,
        data: DateTime(2020, 07, 13)),
    Transacao(
        id: 3,
        descricao: 'Celula',
        valor: 2999.99,
        data: DateTime(2020, 07, 01)),
    Transacao(
        id: 4, descricao: 'Lanche', valor: 30.99, data: DateTime(2020, 07, 01)),
    Transacao(
        id: 5,
        descricao: 'Sorvete',
        valor: 19.99,
        data: DateTime(2020, 07, 01)),
    Transacao(
        id: 6,
        descricao: 'Gasolina',
        valor: 199.99,
        data: DateTime(2020, 07, 01)),
  ];

  void _adicionar(String descricao, double valor) {
    if (descricao.isNotEmpty) {
      final novo = Transacao(
          id: _transacoes.length + 1,
          descricao: descricao,
          valor: valor,
          data: DateTime.now());

      setState(() {
        _transacoes.add(novo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransacaoNovo(_adicionar),
        TransacaoLista(_transacoes)
      ],
    );
  }
}
