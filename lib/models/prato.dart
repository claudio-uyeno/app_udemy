import 'package:flutter/foundation.dart';

class Prato {
  final String id;
  final List<String> categorias;
  final String titulo;
  final String imageUrl;
  final List<String> ingredientes;
  final List<String> passos;
  final int duracao;
  final Complexidade complexidade;
  final Preco preco;
  final bool semGluten;
  final bool semLactose;
  final bool ehVegano;
  final bool ehVegetariano;

  const Prato(
      {@required this.id,
      @required this.categorias,
      @required this.titulo,
      @required this.imageUrl,
      @required this.ingredientes,
      @required this.passos,
      @required this.duracao,
      @required this.complexidade,
      @required this.preco,
      @required this.semGluten,
      @required this.semLactose,
      @required this.ehVegano,
      @required this.ehVegetariano});
}

enum Complexidade { Facil, Medio, Dificil }

enum Preco { Barato, Caro, Gourmet }
