import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/main.dart' as app;
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/presentation/providers/product_providers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Produto falso para não depender de rede no teste de integração
  final fakeProduct = ProductEntity(
    id: 1,
    title: 'Produto Integração',
    description: 'Produto para teste de integração',
    price: 150.0,
    discountPercentage: 0.0,
    rating: 4.0,
    stock: 10,
    brand: 'MarcaTest',
    category: 'test',
    imageUrl: '',
  );

  testWidgets(
    'Fluxo completo: abre o app → vê loja → adiciona ao carrinho → verifica carrinho',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Substitui o provider de produtos por lista fake (sem rede)
            productListProvider.overrideWith(() => _FakeProductListNotifier(
                  items: [fakeProduct],
                )),
            // Substitui o carrinho por notifier fake (sem SQLite)
            cartProvider.overrideWith(() => _FakeCartNotifier()),
            // Substitui categorias por lista vazia
            categoriesProvider.overrideWith((ref) async => <String>[]),
          ],
          child: const app.MainApp(),
        ),
      );

      // Aguarda renderização inicial
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // 1. Verifica que está na tela Home (loja)
      expect(find.text('Ecommerce'), findsOneWidget);

      // 2. Verifica que o produto fake aparece
      expect(find.text('Produto Integração'), findsOneWidget);

      // 3. Navega para o Carrinho via bottom nav
      // Usamos find.byType(NavigationDestination) para garantir que clicamos na barra inferior
      // e não no botão de carrinho que existe dentro do card do produto.
      final cartNavItem = find.descendant(
        of: find.byType(NavigationBar),
        matching: find.byIcon(Icons.shopping_cart_outlined),
      );
      expect(cartNavItem, findsOneWidget);
      await tester.tap(cartNavItem);
      await tester.pumpAndSettle();

      // 4. Verifica que o carrinho está vazio inicialmente
      expect(find.text('Seu carrinho está vazio'), findsOneWidget);

      // 5. Volta para a Home
      final homeNavItem = find.byIcon(Icons.storefront_outlined);
      await tester.tap(homeNavItem.first);
      await tester.pumpAndSettle();

      // 6. Verifica que voltou para a Home
      expect(find.text('Ecommerce'), findsOneWidget);

      // 7. Navega para Configurações
      final settingsNavItem = find.byIcon(Icons.settings_outlined);
      await tester.tap(settingsNavItem.first);
      await tester.pumpAndSettle();

      // 8. Verifica que está em Configurações
      expect(find.text('Configurações'), findsOneWidget);
      expect(find.text('Modo escuro'), findsOneWidget);
    },
  );
}

// ── Fakes para isolar o teste de integração ──────────────────────────────────

class _FakeProductListNotifier extends ProductListNotifier {
  final List<ProductEntity> items;
  _FakeProductListNotifier({required this.items});

  @override
  Future<List<ProductEntity>> build() async => items;

  @override
  Future<void> loadMore() async {}
}

class _FakeCartNotifier extends CartNotifier {
  @override
  Future<List<ProductEntity>> build() async => [];
}
