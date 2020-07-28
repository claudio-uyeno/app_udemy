import 'package:flutter/material.dart';

import '../models/transacao.dart';
import './transacao_lista.dart';
import './transacao_novo.dart';
import './chart.dart';

class TransacaoHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransacaoHomeState();
  }
}

class _TransacaoHomeState extends State<TransacaoHome> {
  final List<Transacao> _transacoes = List<Transacao>();
  // final List<Transacao> _transacoes = [
  //   Transacao(
  //       id: 1, descricao: 'Tênis', valor: 99.99, data: DateTime(2020, 07, 01)),
  //   Transacao(
  //       id: 2,
  //       descricao: 'Notebook',
  //       valor: 2499.99,
  //       data: DateTime(2020, 07, 13)),
  //   Transacao(
  //       id: 3,
  //       descricao: 'Celula',
  //       valor: 2999.99,
  //       data: DateTime(2020, 07, 01)),
  //   Transacao(
  //       id: 4, descricao: 'Lanche', valor: 30.99, data: DateTime(2020, 07, 01)),
  //   Transacao(
  //       id: 5,
  //       descricao: 'Sorvete',
  //       valor: 19.99,
  //       data: DateTime(2020, 07, 01)),
  //   Transacao(
  //       id: 6,
  //       descricao: 'Gasolina',
  //       valor: 199.99,
  //       data: DateTime(2020, 07, 01)),
  // ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Transações'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _novaTransacaoForm(context),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 5, //drop shadow
                child: Chart(_transacoesRecentes),
              ),
            ),
            TransacaoLista(_transacoes),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _novaTransacaoForm(context),
        ),
      ),
    );
  }

  void _novaTransacaoForm(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: TransacaoNovo(_adicionar),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

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

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((x) {
      return x.data.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
}
