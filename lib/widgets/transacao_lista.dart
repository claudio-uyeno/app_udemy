import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transacao.dart';

class TransacaoLista extends StatelessWidget {
  final List<Transacao> transacoes;

  TransacaoLista(this.transacoes);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transacoes.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'Não existem transações!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, idx) {
                //return _listaSimples(ctx, idx);
                return _tileListRight(ctx, idx);
              },
              itemCount: transacoes.length,
            ),
      height: 300,
    );
  }

  Widget _simpleList(BuildContext context, int idx) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                transacoes[idx].descricao,
                style: Theme.of(context).textTheme.headline6,
                // TextStyle(
                //   fontSize: 16,
                //   color: Theme.of(context).primaryColor,
                // ),
                textAlign: TextAlign.right,
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(transacoes[idx].data),
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColorDark,
                ),
                textAlign: TextAlign.right,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              'R\$ ${transacoes[idx].valor.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tileListLeft(BuildContext context, int idx) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            child: FittedBox(
              child: Text('R\$ ${transacoes[idx].valor.toStringAsFixed(2)}'),
            ),
            padding: EdgeInsets.all(6),
          ),
        ),
        title: Text(
          transacoes[idx].descricao,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(transacoes[idx].data),
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).primaryColorDark,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    );
  }

  Widget _tileListRight(BuildContext context, int idx) {
    return Card(
      child: ListTile(
        trailing: CircleAvatar(
          radius: 30,
          child: Padding(
            child: FittedBox(
              child: Text('R\$ ${transacoes[idx].valor.toStringAsFixed(2)}'),
            ),
            padding: EdgeInsets.all(6),
          ),
        ),
        title: Text(
          transacoes[idx].descricao,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(transacoes[idx].data),
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).primaryColorDark,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    );
  }
}
