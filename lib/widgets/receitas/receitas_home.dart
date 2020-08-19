import 'package:flutter/material.dart';

import './screens/abas_screen.dart';
import './screens/abas_screen_bottom.dart';
import '../../models/prato.dart';

class ReceitasHome extends StatefulWidget {
  final List<Prato> _favoritos;

  ReceitasHome(this._favoritos);

  @override
  State<StatefulWidget> createState() {
    return _ReceitasHomeState();
  }
}

class _ReceitasHomeState extends State<ReceitasHome> {
  @override
  Widget build(BuildContext context) {
    return AbasScreenBottom(widget._favoritos);
  }
}
