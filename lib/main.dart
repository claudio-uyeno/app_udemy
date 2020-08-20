import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/receitas/app_receitas.dart';
import './widgets/transacoes/app_transacoes.dart';
import './widgets/shop/app_shop.dart';

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
    return AppShop();
    //return AppTransacoes();
    //return AppReceitas();
  }
}