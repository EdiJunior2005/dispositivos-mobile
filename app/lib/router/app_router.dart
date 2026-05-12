import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../pages/tela_principal_page.dart';
import '../pages/detalhes_filme_page.dart';
import '../models/filme_item.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: TelaPrincipalMovieRoute.page, initial: true),
    AutoRoute(page: DetalhesFilmeRoute.page),
  ];
}