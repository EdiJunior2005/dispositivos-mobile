import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/presentation/providers/product_providers.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:ecommerce_app/widgets/cart_button.dart';
import 'package:ecommerce_app/features/cart/cart_page.dart';

// Helper para criar um ProductEntity de teste
ProductEntity fakeProduct({
  int id = 1,
  String title = 'Produto Teste Widget',
  double price = 199.99,
  double discountPercentage = 10.0,
  double rating = 4.5,
  int stock = 30,
  String category = 'electronics',
}) =>
    ProductEntity(
      id: id,
      title: title,
      description: 'Descrição do produto',
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      brand: 'MarcaTeste',
      category: category,
      imageUrl: '',
    );

void main() {
  // ── Teste Widget 1: ProductCard exibe título e preço ──────────────────────

  testWidgets('ProductCard exibe título e preço com desconto', (tester) async {
    final product = fakeProduct(price: 200.0, discountPercentage: 10.0);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cartProvider.overrideWith(() => _FakeCartNotifier()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: ProductCard(product: product),
          ),
        ),
      ),
    );

    // Título aparece
    expect(find.text('Produto Teste Widget'), findsOneWidget);

    // Preço com desconto: 200 * 0.9 = 180.00
    expect(find.textContaining('180.00'), findsOneWidget);

    // Badge de desconto
    expect(find.textContaining('-10%'), findsOneWidget);
  });

  // ── Teste Widget 2: CartButton alterna estado ─────────────────────────────

  testWidgets('CartButton exibe ícone vazio quando produto não está no carrinho',
      (tester) async {
    final product = fakeProduct();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cartProvider.overrideWith(() => _FakeCartNotifier()),
        ],
        child: MaterialApp(
          home: Scaffold(body: CartButton(product: product)),
        ),
      ),
    );

    // Ícone de carrinho vazio (not in cart)
    expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
  });

  // ── Teste Widget 3: CartPage exibe mensagem quando vazia ─────────────────

  testWidgets('CartPage exibe mensagem de carrinho vazio', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cartProvider.overrideWith(() => _FakeCartNotifier(items: [])),
        ],
        child: const MaterialApp(home: CartPage()),
      ),
    );

    await tester.pump();

    expect(find.text('Seu carrinho está vazio'), findsOneWidget);
    expect(find.text('Continuar comprando'), findsOneWidget);
  });
}

// Fake notifier para isolar os testes de widget do banco de dados real
class _FakeCartNotifier extends CartNotifier {
  final List<ProductEntity> items;
  _FakeCartNotifier({this.items = const []});

  @override
  Future<List<ProductEntity>> build() async => items;
}
