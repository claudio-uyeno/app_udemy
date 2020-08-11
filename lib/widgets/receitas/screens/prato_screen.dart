import 'package:app_udemy/models/prato.dart';
import 'package:flutter/material.dart';

import '../../../fake/pratos_fake.dart';

class PratoScreen extends StatelessWidget {
  static const routeName = '/prato-detalhes';

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;
    final prato = PRATOS_FAKE.firstWhere((p) => p.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(prato.titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(prato.imageUrl, fit: BoxFit.cover),
            ),
            buildSessao(context, 'Ingredientes'),
            buildListaInformacoes(
              context,
              prato,
              ListView.builder(
                itemCount: prato.ingredientes.length,
                itemBuilder: (ctx, idx) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(prato.ingredientes[idx]),
                  ),
                ),
              ),
            ),
            buildSessao(context, 'Passos'),
            buildListaInformacoes(
                context,
                prato,
                ListView.builder(
                  itemCount: prato.passos.length,
                  itemBuilder: (ctx, idx) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${idx + 1}'),
                        ),
                        title: Text(prato.passos[idx]),
                      ),
                      Divider(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildListaInformacoes(
      BuildContext context, Prato prato, Widget filho) {
    return Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: filho);
  }

  Widget buildSessao(BuildContext context, String descricao) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        descricao,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
