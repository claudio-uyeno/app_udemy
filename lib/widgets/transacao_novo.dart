import 'package:flutter/material.dart';

class TransacaoNovo extends StatefulWidget {
  final Function adicionarOnPressed;

  TransacaoNovo(this.adicionarOnPressed);

  @override
  _TransacaoNovoState createState() => _TransacaoNovoState();
}

class _TransacaoNovoState extends State<TransacaoNovo> {
  final descricaoController = TextEditingController();

  final valorController = TextEditingController();

  void _adicionar() {
    final descricao = descricaoController.text;
    final valor = double.parse(valorController.text);

    if (descricao.isEmpty || valor <= 0) {
      return;
    }

    widget.adicionarOnPressed(descricao, valor);

    Navigator.of(context).pop();  //encerra o contexto mais ao topo
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição')),
            TextField(
              controller: valorController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _adicionar(),
            ),
            FlatButton(
                child: Text(
                  'Adicionar',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.right,
                ),
                onPressed: _adicionar),
          ],
        ),
      ),
    );
  }
}
