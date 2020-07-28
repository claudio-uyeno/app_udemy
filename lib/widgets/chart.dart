import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transacao.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transacao> transacoesRecente;

  Chart(this.transacoesRecente);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        child: Row(
          children: transacoesPorDia.map((dados) {
            var percentual = totalDespesas != 0.0
                ? (dados['valor'] as double) / totalDespesas
                : 0.0;
            return Flexible(
              child: ChartBar(dados['dia'], dados['valor'], percentual),
              fit: FlexFit.tight,
            );
          }).toList(),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        padding: EdgeInsets.all(10),
      ),
      elevation: 7,
      margin: EdgeInsets.all(10),
    );
  }

  List<Map<String, Object>> get transacoesPorDia {
    return List.generate(7, (index) {
      final data = DateTime.now().subtract(Duration(days: index));
      var total = 0.0;

      for (var transacao in transacoesRecente) {
        if (transacao.data.day == data.day &&
            transacao.data.month == data.month &&
            transacao.data.year == data.year) {
          total += transacao.valor;
        }
      }

      return {'dia': DateFormat.E().format(data), 'valor': total};
    }).reversed.toList();
  }

  double get totalDespesas {
    return transacoesPorDia.fold(0.0, (x, item) {
      return x + item['valor'];
    });
  }
}
