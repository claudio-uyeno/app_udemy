import 'package:app_udemy/widgets/receitas/menu_lateral.dart';
import 'package:flutter/material.dart';

class FiltrosScreen extends StatefulWidget {
  static const routeName = '/filtros';

  final Map<String, bool> filtroAtual;
  final Function atualizarFiltro;

  FiltrosScreen(this.filtroAtual, this.atualizarFiltro);

  @override
  _FiltrosScreenState createState() => _FiltrosScreenState();
}

class _FiltrosScreenState extends State<FiltrosScreen> {
  var _semGluten = false;
  var _semLactose = false;
  var _ehVegano = false;
  var _ehVegetariano = false;

  @override
  void initState() {
    _semGluten = widget.filtroAtual['gluten'];
    _semLactose = widget.filtroAtual['lactose'];
    _ehVegano = widget.filtroAtual['vegano'];
    _ehVegetariano = widget.filtroAtual['vegetariano'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtros'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                widget.atualizarFiltro({
                  'gluten': _semGluten,
                  'lactose': _semLactose,
                  'vegano': _ehVegano,
                  'vegetariano': _ehVegetariano
                });
              }),
        ],
      ),
      drawer: MenuLateral(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Filtrar pratos'),
          ),
          Expanded(
              child: ListView(
            children: [
              opcoesBuilder(
                'Sem Gluten',
                'Exibir pratos sem gluten.',
                _semGluten,
                (novoValor) {
                  setState(
                    () {
                      _semGluten = novoValor;
                    },
                  );
                },
              ),
              opcoesBuilder(
                'Sem Lactose',
                'Exibir pratos sem lactose.',
                _semLactose,
                (novoValor) {
                  setState(
                    () {
                      _semLactose = novoValor;
                    },
                  );
                },
              ),
              opcoesBuilder(
                'Vegano',
                'Exibir pratos veganos.',
                _ehVegano,
                (novoValor) {
                  setState(
                    () {
                      _ehVegano = novoValor;
                    },
                  );
                },
              ),
              opcoesBuilder(
                'Vegetariano',
                'Exibir pratos vegetarianos.',
                _ehVegetariano,
                (novoValor) {
                  setState(
                    () {
                      _ehVegetariano = novoValor;
                    },
                  );
                },
              ),
            ],
          ))
        ],
      ),
    );
  }

  SwitchListTile opcoesBuilder(
      String descricao, String dica, bool valorAtual, Function atualizar) {
    return SwitchListTile(
      title: Text(descricao),
      value: valorAtual,
      subtitle: Text(dica),
      onChanged: atualizar,
    );
  }
}
