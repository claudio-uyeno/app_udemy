import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transacao.dart';

class TransacaoItemTileLeft extends StatelessWidget {
  const TransacaoItemTileLeft({
    Key key,
    @required this.transacao,
    @required this.excluirTransacao,
  }) : super(key: key);

  final Transacao transacao;
  final Function excluirTransacao;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
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
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                onPressed: () => excluirTransacao(transacao.id),
                icon: Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).errorColor,
                ),
                label: const Text('Excluir'))
            : IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => excluirTransacao(transacao.id),
              ),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    );
  }
}
