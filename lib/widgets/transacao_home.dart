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
  bool _exibirGrafico = false;
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
    final paisagem =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final _appBar = AppBar(
      title: Text('Transações'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _novaTransacaoForm(context),
        )
      ],
    );

    Widget _buildGrafico(double percent) {
      return Container(
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5, //drop shadow
          child: Chart(_transacoesRecentes),
        ),
        height: (MediaQuery.of(context).size.height -
                _appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            percent,
      );
    }

    Widget _buildListaTransacoes(double percent) {
      return Container(
        child: TransacaoLista(_transacoes, _excluir),
        height: (MediaQuery.of(context).size.height -
                _appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            percent,
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: _appBar,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (paisagem)
              Center(
                child: Switch(
                  value: _exibirGrafico,
                  onChanged: (val) {
                    setState(() {
                      _exibirGrafico = val;
                    });
                  },
                ),
              ),
            if (!paisagem) _buildGrafico(0.3),
            if (!paisagem) _buildListaTransacoes(0.7),
            if (paisagem)
              _exibirGrafico ? _buildGrafico(0.8) : _buildListaTransacoes(0.8),
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

  void _adicionar(String descricao, double valor, DateTime data) {
    if (descricao.isNotEmpty) {
      final novo = Transacao(
          id: _transacoes.length + 1,
          descricao: descricao,
          valor: valor,
          data: data);

      setState(() {
        _transacoes.add(novo);
      });
    }
  }

  void _excluir(int id) {
    setState(() {
      _transacoes.removeWhere((transacao) => transacao.id == id);
    });
  }

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((x) {
      return x.data.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
}
