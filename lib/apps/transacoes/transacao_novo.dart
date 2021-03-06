import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptative_flat_button.dart';

class TransacaoNovo extends StatefulWidget {
  final Function adicionarOnPressed;

  TransacaoNovo(this.adicionarOnPressed);

  @override
  _TransacaoNovoState createState() => _TransacaoNovoState();
}

class _TransacaoNovoState extends State<TransacaoNovo> {
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  DateTime _data;

  void _adicionar() {
    if (_descricaoController.text.isEmpty ||
        _valorController.text.isEmpty ||
        _data == null) {
      return;
    }

    final descricao = _descricaoController.text;
    final valor = double.parse(_valorController.text);

    if (valor <= 0) {
      return;
    }

    widget.adicionarOnPressed(descricao, valor, _data);

    Navigator.of(context).pop(); //encerra o contexto mais ao topo
  }

  void _selecionarData() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() => _data = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10), //corrigir problema do teclado sobre o fomulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  controller: _descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição')),
              TextField(
                controller: _valorController,
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _adicionar(),
              ),
              Row(
                children: <Widget>[
                  Text(
                    _data == null
                        ? '??/??/??'
                        : DateFormat('dd/MM/yy').format(_data),
                  ),
                  AdaptativeFlatButton('Seleionar data', _selecionarData),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              RaisedButton(
                  child: Text(
                    'Adicionar',
                    style: TextStyle(
                      color: Theme.of(context).buttonColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: _adicionar),
            ],
          ),
        ),
      ),
    );
  }
}
