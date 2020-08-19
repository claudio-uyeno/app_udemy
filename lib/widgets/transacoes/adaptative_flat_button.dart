import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeFlatButton extends StatelessWidget {
  final String _texto;
  final Function _onPressed;

  AdaptativeFlatButton(this._texto, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              _texto,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: _onPressed,
          )
        : FlatButton(
            child: Text(_texto),
            textColor: Theme.of(context).primaryColor,
            onPressed: _onPressed,
          );
  }
}
