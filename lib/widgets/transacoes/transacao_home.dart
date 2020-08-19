import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/transacao.dart';
import './transacao_lista.dart';
import './transacao_novo.dart';
import './chart.dart';

class TransacaoHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransacaoHomeState();
  }
}

class _TransacaoHomeState extends State<TransacaoHome>
    with WidgetsBindingObserver {
  bool _exibirGrafico = false;
  //final List<Transacao> _transacoes = List<Transacao>();
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
        descricao: 'Celular',
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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paisagem =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget _appBar = _buildAppBar();

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

    List<Widget> _buildPortrait() {
      return [_buildGrafico(0.3), _buildListaTransacoes(0.7)];
    }

    Widget _buildLandscape(bool exibirGrafico) {
      return exibirGrafico ? _buildGrafico(0.8) : _buildListaTransacoes(0.8);
    }

    final _body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (paisagem)
              Center(
                child: Switch.adaptive(
                  //adapta conforme o SO
                  value: _exibirGrafico,
                  onChanged: (val) {
                    setState(() {
                      _exibirGrafico = val;
                    });
                  },
                ),
              ),
            if (!paisagem) ..._buildPortrait(),
            if (paisagem) _buildLandscape(_exibirGrafico),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _body,
            navigationBar: _appBar,
          )
        : Scaffold(
            appBar: _appBar,
            body: _body,
            floatingActionButton: Platform.isIOS
                ? Container() //não renderiza nada para IOS
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _novaTransacaoForm(context),
                  ),
          );
  }

  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Transações'),
            trailing: Row(
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _novaTransacaoForm(context),
                )
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          )
        : AppBar(
            title: Text('Transações'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _novaTransacaoForm(context),
              )
            ],
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
