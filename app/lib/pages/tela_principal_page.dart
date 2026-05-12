import 'dart:convert';


import 'package:auto_route/auto_route.dart';
import 'package:example_application/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/filme_item.dart';
import '../models/tema_item.dart';
import '../widgets/filmes_listview.dart';
import '../widgets/temas_gridview.dart';

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

Future<List<FilmeItem>> carregarFilmes() async {
  final String jsonString = await rootBundle.loadString(
    'assets/data/filmes.json',
  );

  final List<dynamic> dados = jsonDecode(jsonString) as List<dynamic>;

  return dados
      .cast<Map<String, dynamic>>()
      .map(FilmeItem.fromJson)
      .toList(growable: false);
}

@RoutePage()
class TelaPrincipalMoviePage extends StatefulWidget {
  const TelaPrincipalMoviePage({super.key});

  @override
  State<TelaPrincipalMoviePage> createState() => _TelaPrincipalMoviePageState();
}

class _TelaPrincipalMoviePageState extends State<TelaPrincipalMoviePage> {
  late Future<List<FilmeItem>> _filmesFuture;

  @override
  void initState() {
    super.initState();

    _filmesFuture = carregarFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App - Lista de Filmes'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Temas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(flex: 1, child: TemasGridView(temas: temas)),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'Filmes em Destaque',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 4,
              child: FutureBuilder<List<FilmeItem>>(
                future: _filmesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar filmes'));
                  }

                  final List<FilmeItem> filmes = snapshot.data ?? [];

                  return FilmesListView(
                    filmes: filmes,
                    onTap: (filme) {
                      context.router.push(DetalhesFilmeRoute(filme: filme));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
