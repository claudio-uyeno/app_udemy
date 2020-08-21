import 'package:flutter/material.dart';

import '../../../models/prato.dart';
import '../../../fake/pratos_fake.dart';
import '../prato_item.dart';

class CategoriaReceitasScreen extends StatefulWidget {
  static const routeName = '/categoria-pratos';

  final List<Prato> pratosPorCategoria;

  CategoriaReceitasScreen(this.pratosPorCategoria);

  @override
  _CategoriaReceitasScreenState createState() => _CategoriaReceitasScreenState();
}

class _CategoriaReceitasScreenState extends State<CategoriaReceitasScreen> {
  bool _inicializado = false;
  String titulo;
  List<Prato> _pratosVisiveis;

  @override
  void didChangeDependencies() {
    if (!_inicializado) {
      final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
      final id = routeArgs['id'];
      titulo = routeArgs['titulo'];
      _pratosVisiveis = widget.pratosPorCategoria.where((prato) {
        return prato.categorias.contains(id);
      }).toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          var prato = _pratosVisiveis[idx];
          return Card(
            child: PratoItem(
              id: prato.id,
              imageUrl: prato.imageUrl,
              titulo: prato.titulo,
              duracao: prato.duracao,
              complexidade: prato.complexidade,
              preco: prato.preco,
              remover: removerItem,
            ),
          );
        },
        itemCount: _pratosVisiveis.length,
      ),
    );
  }

  void removerItem(String id) {
    setState(() {
      _pratosVisiveis.removeWhere((p) => p.id == id);
    });
  }
}
