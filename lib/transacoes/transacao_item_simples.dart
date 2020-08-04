import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transacao.dart';

class TransacaoItemSimples extends StatelessWidget {
  const TransacaoItemSimples({
    Key key,
    @required this.transacao,
  }) : super(key: key);

  final Transacao transacao;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                transacao.descricao,
                style: Theme.of(context).textTheme.headline6,
                // TextStyle(
                //   fontSize: 16,
                //   color: Theme.of(context).primaryColor,
                // ),
                textAlign: TextAlign.right,
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(transacao.data),
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
              'R\$ ${transacao.valor.toStringAsFixed(2)}',
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
}
