import 'package:flutter/material.dart';

import './quiz.dart';
import './resultado.dart';

// void main() {
//   runApp(QuestionarioApp());
// }

class QuestionarioApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuestionarioAppState();
  }
}

class _QuestionarioAppState extends State<QuestionarioApp> {
  final _perguntas = const [
    {
      'pergunta': 'Qual a sua cor favorita?',
      'opcoes': [
        {'descricao': 'Preto', 'ponto': 1},
        {'descricao': 'Branco', 'ponto': 2},
        {'descricao': 'Cinza', 'ponto': 3},
        {'descricao': 'Vermelho', 'ponto': 4},
        {'descricao': 'Verde', 'ponto': 5},
        {'descricao': 'Azul', 'ponto': 6}
      ],
    },
    {
      'pergunta': 'Qual seu animal favorito?',
      'opcoes': [
        {'descricao': 'Cachorro', 'ponto': 3},
        {'descricao': 'Gato', 'ponto': 2},
        {'descricao': 'Passarinho', 'ponto': 1}
      ]
    }
  ];
  var _idPergunta = 0;
  var _total = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Teste'),
        ),
        body: (_idPergunta < _perguntas.length)
            ? Quiz(
                perguntas: _perguntas,
                idPergunta: _idPergunta,
                responderPergunta: _responderPergunta,
              )
            : Resultado(_total, _reset),
      ),
    );
  }

  void _responderPergunta(int pontos) {
    _total += pontos;
    setState(() {
      _idPergunta++;
    });
  }

  void _reset() {
    setState(() {
      _idPergunta = 0;
    });
  }
}
