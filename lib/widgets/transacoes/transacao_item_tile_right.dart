import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transacao.dart';

class TransacaoItemTileRight extends StatelessWidget {
  const TransacaoItemTileRight({
    Key key,
    @required this.transacao,
  }) : super(key: key);

  final Transacao transacao;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: CircleAvatar(
          radius: 30,
          child: Padding(
            child: FittedBox(
              child: Text('R\$ ${transacao.valor.toStringAsFixed(2)}'),
            ),
            padding: EdgeInsets.all(6),
          ),
        ),
        title: Text(
          transacao.descricao,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(transacao.data),
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