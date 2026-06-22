import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../product/presentation/providers/product_providers.dart';
import '../../widgets/cart_button.dart';

class DetailPage extends ConsumerWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProduct = ref.watch(productDetailProvider(id));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return asyncProduct.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Erro: $e')),
      ),
      data: (product) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () => context.go('/')),
            title: Text(product.brand, style: const TextStyle(fontSize: 16)),
            actions: [CartButton(product: product)],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagem
                Container(
                  width: double.infinity,
                  height: 300,
                  color: colorScheme.surfaceContainerHighest,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.image_not_supported, size: 80),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Categoria
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.category,
                          style: TextStyle(
                            color: colorScheme.onSecondaryContainer,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Título
                      Text(product.title, style: theme.textTheme.titleLarge),
                      const SizedBox(height: 8),

                      // Rating
                      Row(
                        children: [
                          ...List.generate(5, (i) {
                            return Icon(
                              i < product.rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 20,
                              color: Colors.amber[700],
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            '${product.rating.toStringAsFixed(1)} / 5.0',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Preços
                      if (product.discountPercentage > 0) ...[
                        Text(
                          'R\$ ${product.price.toStringAsFixed(2)}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              'R\$ ${product.priceWithDiscount.toStringAsFixed(2)}',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.error,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '-${product.discountPercentage.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  color: colorScheme.onError,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ] else
                        Text(
                          'R\$ ${product.price.toStringAsFixed(2)}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      const SizedBox(height: 16),

                      // Estoque
                      Row(
                        children: [
                          Icon(
                            product.stock > 0
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: product.stock > 0
                                ? Colors.green
                                : colorScheme.error,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            product.stock > 0
                                ? '${product.stock} em estoque'
                                : 'Sem estoque',
                            style: TextStyle(
                              color: product.stock > 0
                                  ? Colors.green
                                  : colorScheme.error,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 12),

                      // Descrição
                      Text(
                        'Descrição',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Botão adicionar ao carrinho
                      SizedBox(
                        width: double.infinity,
                        child: Consumer(
                          builder: (context, ref, _) {
                            final cartItems =
                                ref.watch(cartProvider).value ?? [];
                            final isInCart =
                                cartItems.any((p) => p.id == product.id);

                            return FilledButton.icon(
                              onPressed: () {
                                if (isInCart) {
                                  ref
                                      .read(cartProvider.notifier)
                                      .remove(product.id);
                                } else {
                                  ref.read(cartProvider.notifier).add(product);
                                }
                              },
                              icon: Icon(
                                isInCart
                                    ? Icons.remove_shopping_cart
                                    : Icons.add_shopping_cart,
                              ),
                              label: Text(
                                isInCart
                                    ? 'Remover do carrinho'
                                    : 'Adicionar ao carrinho',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
