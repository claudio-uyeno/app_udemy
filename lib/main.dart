import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/transacoes/transacao_home.dart';
import './widgets/receitas/receitas_home.dart';
import './widgets/receitas/screens/categoria_receitas_screen.dart';
import './widgets/receitas/screens/prato_screen.dart';
import './widgets/receitas/screens/filtros_screen.dart';
import './fake/pratos_fake.dart';
import './models/prato.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]); //limita orientações
  runApp(AppUdemy());
}

class AppUdemy extends StatefulWidget {
  @override
  _AppUdemyState createState() => _AppUdemyState();
}

class _AppUdemyState extends State<AppUdemy> {
  Map<String, bool> _filtros = {
    'gluten': false,
    'lactose': false,
    'vegano': false,
    'vegetariano': false
  };

  List<Prato> _pratosPorCategoria = PRATOS_FAKE;
  List<Prato> _favoritos = [];

  void _setFiltros(Map<String, bool> filtros) {
    setState(() {
      _filtros = filtros;

      _pratosPorCategoria = PRATOS_FAKE.where((p) {
        if (_filtros['gluten'] && !p.semGluten) {
          return false;
        }
        if (_filtros['lactose'] && !p.semLactose) {
          return false;
        }
        if (_filtros['vegano'] && !p.ehVegano) {
          return false;
        }
        if (_filtros['vegetariano'] && !p.ehVegetariano) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorito(String id) {
    final pratoId = _favoritos.indexWhere((p) => p.id == id);

    if (pratoId >= 0) {
      setState(() {
        _favoritos.removeAt(pratoId);
      });
    } else {
      setState(() {
        _favoritos.add(_pratosPorCategoria.firstWhere((p) => p.id == id));
      });
    }
  }

  bool _ehFavorito(String id) {
    return _favoritos.any((p) => p.id == id);
  }

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
      home: ReceitasHome(_favoritos),
      //initialRoute: '/',  //default
      routes: {
        //'/': (ctx) => ReceitasHome(),  //home poderia ser definido aqui também
        CategoriaReceitasScreen.routeName: (ctx) =>
            CategoriaReceitasScreen(_pratosPorCategoria),
        PratoScreen.routeName: (ctx) => PratoScreen(_toggleFavorito, _ehFavorito),
        FiltrosScreen.routeName: (ctx) => FiltrosScreen(_filtros, _setFiltros),
      },
      // onGenerateRoute: (config) {
      //   if (config.name == '/rota-atual') {
      //     return null;
      //   }
      //   return MaterialPageRoute(builder: (ctx) => CategoriaReceitasScreen());
      // },
      onUnknownRoute: (config) {
        return MaterialPageRoute(
            builder: (ctx) => CategoriaReceitasScreen(_pratosPorCategoria));
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
