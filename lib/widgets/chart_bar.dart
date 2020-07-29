import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dia;
  final double valorGasto;
  final double gastoPercentual;

  ChartBar(this.dia, this.valorGasto, this.gastoPercentual);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('R\$ ${valorGasto.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
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
            height: constraints.maxHeight * 0.55,
            width: 10,
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            child: Text(dia),
            height: constraints.maxHeight * 0.2,
          ),
        ],
      );
    });
  }
}
