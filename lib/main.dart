import 'package:app_udemy/apps/dispositivos/app_dispositivos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './apps/receitas/app_receitas.dart';
import './apps/transacoes/app_transacoes.dart';
import './apps/shop/app_shop.dart';

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
    return AppDispositivos();
    //return AppTransacoes();
    //return AppReceitas();
  }
}