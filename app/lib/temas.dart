import 'dart:ui';

import 'package:example_application/models/tema_item.dart';

const List<TemaItem> temas = <TemaItem>[
  TemaItem(
    nome: 'Ação',
    imageUrl: 'https://picsum.photos/seed/acao/500/350',
    cor: Color(0xFF264653),
  ),
  TemaItem(
    nome: 'Comédia',
    imageUrl: 'https://picsum.photos/seed/comedia/500/350',
    cor: Color(0xFF2A9D8F),
  ),
  TemaItem(
    nome: 'Drama',
    imageUrl: 'https://picsum.photos/seed/drama/500/350',
    cor: Color(0xFFE76F51),
  ),
  TemaItem(
    nome: 'Ficção Científica',
    imageUrl: 'https://picsum.photos/seed/ficcao/500/350',
    cor: Color(0xFF1D3557),
  ),
  TemaItem(
    nome: 'Suspense',
    imageUrl: 'https://picsum.photos/seed/suspense/500/350',
    cor: Color(0xFF6A4C93),
  ),
  TemaItem(
    nome: 'Animação',
    imageUrl: 'https://picsum.photos/seed/animacao/500/350',
    cor: Color(0xFFF4A261),
  ),
];
