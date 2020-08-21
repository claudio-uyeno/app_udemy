import 'package:flutter/material.dart';

import './transacao_home.dart';

class AppTransacoes extends StatelessWidget {
  const AppTransacoes({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Udemy',
      home: TransacaoHome(),
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
      ),
    );
  }
}
