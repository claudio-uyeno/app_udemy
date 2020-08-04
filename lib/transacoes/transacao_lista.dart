import 'package:flutter/material.dart';

import '../models/transacao.dart';

import './transacao_item_simples.dart';
import './transacao_item_tile_left.dart';
import './transacao_item_tile_right.dart';

class TransacaoLista extends StatelessWidget {
  final List<Transacao> transacoes;
  Function excluirTransacao;

  TransacaoLista(this.transacoes, this.excluirTransacao);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transacoes.isEmpty
          ? LayoutBuilder(builder: (ctx, cts) {
              return Column(
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
                    height: cts.maxHeight * 0.6,
                  )
                ],
              );
            })
          : ListView(
              children: transacoes
                  .map((transacao) => TransacaoItemTileLeft(
                      key: ValueKey(transacao.id),
                      transacao: transacao,
                      excluirTransacao: excluirTransacao))
                  .toList(),
            ),
      // : ListView.builder(
      //     itemBuilder: (ctx, idx) {
      //       //return TransacaoItemSimples(transacao: transacoes[idx]);
      //       //return TransacaoItemTileRight(transacao: transacoes[idx]);
      //       return TransacaoItemTileLeft(transacao: transacoes[idx], excluirTransacao: excluirTransacao);
      //     },
      //     itemCount: transacoes.length,
      //   ),
      height: 300,
    );
  }
}
