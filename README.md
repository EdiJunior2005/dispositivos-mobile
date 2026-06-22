# ShopApp - Ecommerce Flutter

Aplicativo de ecommerce desenvolvido com Flutter, baseado em Clean Architecture.

## API
Utiliza a [DummyJSON API](https://dummyjson.com/products) — pública, gratuita, com paginação.

## Funcionalidades
- Listagem de produtos com scroll infinito
- Filtro por categoria
- Tela de detalhe do produto
- Carrinho (persistido com SQLite)
- Modo escuro (salvo com SharedPreferences)

## Arquitetura
```
lib/
  core/database/      # DatabaseHelper (SQLite)
  features/
    product/
      domain/         # Entidades e contratos (repository)
      data/           # Models, Sources, RepositoryImpl
      presentation/   # Providers (Riverpod)
    home/             # Tela principal
    detail/           # Tela de detalhe
    cart/             # Tela de carrinho
    settings/         # Configurações
  widgets/            # Componentes reutilizáveis
  routes/             # GoRouter
```

## Testes
- `test/unit/product_unit_test.dart` — 5 testes de unidade
- `test/widget/product_widget_test.dart` — 3 testes de widget
- `integration_test/app_test.dart` — 1 teste de integração

## Como rodar
```bash
flutter pub get
flutter run
```
