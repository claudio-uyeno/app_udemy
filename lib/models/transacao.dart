import 'package:flutter/foundation.dart';

class Transacao {
  final int id;
  final String descricao;
  final double valor;
  final DateTime data;

  Transacao(
      {@required this.id,
      @required this.descricao,
      @required this.valor,
      @required this.data});
}
