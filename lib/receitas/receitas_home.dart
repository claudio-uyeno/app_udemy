import 'package:flutter/material.dart';

import './categorias.dart';

class ReceitasHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReceitasHomeState();
  }
}

class _ReceitasHomeState extends State<ReceitasHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
      ),
      body: Categorias(),
    );
  }
}
