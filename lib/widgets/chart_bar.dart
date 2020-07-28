import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dia;
  final double valorGasto;
  final double gastoPercentual;

  ChartBar(this.dia, this.valorGasto, this.gastoPercentual);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('R\$ ${valorGasto.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(height: 4),
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: gastoPercentual,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          height: 60,
          width: 10,
        ),
        SizedBox(height: 4),
        Text(dia),
      ],
    );
  }
}
