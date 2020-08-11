import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/transacoes/transacao_home.dart';
import './widgets/receitas/receitas_home.dart';
import './widgets/receitas/screens/categoria_receitas_screen.dart';
import './widgets/receitas/screens/prato_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]); //limita orientações
  runApp(AppUdemy());
}

class AppUdemy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      home: ReceitasHome(),
      //initialRoute: '/',  //default
      routes: {
        //'/': (ctx) => ReceitasHome(),  //home poderia ser definido aqui também
        CategoriaReceitasScreen.routeName: (ctx) => CategoriaReceitasScreen(),
        PratoScreen.routeName: (ctx) => PratoScreen(),
      },
      // onGenerateRoute: (config) {
      //   if (config.name == '/rota-atual') {
      //     return null;
      //   }
      //   return MaterialPageRoute(builder: (ctx) => CategoriaReceitasScreen());
      // },
      onUnknownRoute: (config) {
        return MaterialPageRoute(builder: (ctx) => CategoriaReceitasScreen());
      },
    );
  }
}

class TransacaoApp extends StatelessWidget {
  const TransacaoApp({
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
