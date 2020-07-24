import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transacao.dart';

class TransacaoLista extends StatelessWidget {
  final List<Transacao> transacoes;

  TransacaoLista(this.transacoes);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (ctx, idx) {
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transacoes[idx].descricao,
                      style: Theme.of(context).textTheme.headline6,
                      // TextStyle(
                      //   fontSize: 16,
                      //   color: Theme.of(context).primaryColor,
                      // ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(transacoes[idx].data),
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
                    'R\$ ${transacoes[idx].valor.toStringAsFixed(2)}',
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
        },
        itemCount: transacoes.length,
      ),
      height: 300,
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Column(
//     children: <Widget>[
//       ...transacoes.map((transacao) {
//         return Card(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     transacao.descricao,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.blue,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   Text(
//                     DateFormat('dd/MM/yyyy').format(transacao.data),
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                     ),
//                     textAlign: TextAlign.right,
//                   )
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: 15,
//                   vertical: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.purple,
//                     width: 2,
//                   ),
//                 ),
//                 padding: EdgeInsets.all(10),
//                 child: Text(
//                   'R\$ ${transacao.valor}',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: Colors.purple,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       }).toList(),
//     ],
//   );
// }
