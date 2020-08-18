import 'package:flutter/material.dart';

import '../../models/prato.dart';
import './screens/prato_screen.dart';

class PratoItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String titulo;
  final int duracao;
  final Complexidade complexidade;
  final Preco preco;
  final Function remover;

  PratoItem(
      {@required this.id,
      @required this.imageUrl,
      @required this.titulo,
      @required this.duracao,
      @required this.complexidade,
      @required this.preco,
      @required this.remover});

  void selecionarPrato(BuildContext context) {
    Navigator.of(context).pushNamed(PratoScreen.routeName, arguments: id).then((value) => remover(value));
  }

  String get complexidadeTexto {
    switch (complexidade) {
      case (Complexidade.Facil):
        return 'Fácil';
      case (Complexidade.Medio):
        return 'Médio';
      case (Complexidade.Dificil):
        return 'Difícil';
      default:
        return '???';
    }
  }

  String get precoTexto {
    switch (preco) {
      case (Preco.Barato):
        return 'Barato';
      case (Preco.Caro):
        return 'Caro';
      case (Preco.Gourmet):
        return 'Gourmet';
      default:
        return '???';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selecionarPrato(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      titulo,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.av_timer),
                      SizedBox(
                        width: 5,
                      ),
                      Text('${duracao}min'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 5,
                      ),
                      Text(complexidadeTexto),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 5,
                      ),
                      Text(precoTexto),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
