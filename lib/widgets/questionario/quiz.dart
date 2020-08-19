import 'package:flutter/material.dart';

import './questao.dart';
import './resposta.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int idPergunta;
  final Function responderPergunta;

  Quiz(
      {@required this.perguntas,
      @required this.idPergunta,
      @required this.responderPergunta});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Questao(perguntas[idPergunta]['pergunta']),
        ...(perguntas[idPergunta]['opcoes'] as List<Map<String, Object>>).map((opcao) {
          //precisa usar cast quando utilizado map com lista
          //'...' adiciona os elementos a lista como elementos individuais
          return Resposta(() => responderPergunta(opcao['ponto']), opcao['descricao']);
        }).toList(),
      ],
    );
  }
}
