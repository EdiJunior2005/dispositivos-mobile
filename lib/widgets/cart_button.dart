import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/product/presentation/providers/product_providers.dart';
import '../features/product/domain/entities/product_entity.dart';

class CartButton extends ConsumerWidget {
  final ProductEntity product;
  const CartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider).value ?? [];
    final isInCart = cartItems.any((p) => p.id == product.id);

    return IconButton(
      icon: Icon(
        isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
        color: isInCart ? Theme.of(context).colorScheme.primary : null,
      ),
      onPressed: () {
        if (isInCart) {
          ref.read(cartProvider.notifier).remove(product.id);
        } else {
          ref.read(cartProvider.notifier).add(product);
        }
      },
    );
  }
}
