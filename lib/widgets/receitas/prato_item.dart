import 'package:flutter/material.dart';

class PratoItem extends StatelessWidget {
  final String imageUrl;

  PratoItem({@required this.imageUrl});

  void selecionarPrato() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selecionarPrato(),
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
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
