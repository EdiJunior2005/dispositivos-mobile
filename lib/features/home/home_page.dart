import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../product/presentation/providers/product_providers.dart';
import '../../widgets/product_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final pos = _scrollController.position;
      if (pos.pixels >= pos.maxScrollExtent - 200 && !_isLoadingMore) {
        _isLoadingMore = true;
        ref.read(productListProvider.notifier).loadMore().then((_) {
          _isLoadingMore = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productListProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopApp'),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: categoriesAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (categories) => SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _CategoryChip(
                    label: 'Todos',
                    selected: selectedCategory == null,
                    onTap: () =>
                        ref.read(selectedCategoryProvider.notifier).state = null,
                  ),
                  ...categories.map(
                    (c) => _CategoryChip(
                      label: c,
                      selected: selectedCategory == c,
                      onTap: () =>
                          ref.read(selectedCategoryProvider.notifier).state = c,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: productsAsync.when(
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text('Erro ao carregar produtos\n$e', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(productListProvider),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
        data: (products) {
          final filtered = selectedCategory == null
              ? products
              : products
                  .where((p) => p.category == selectedCategory)
                  .toList();

          if (filtered.isEmpty) {
            return const Center(child: Text('Nenhum produto nesta categoria'));
          }

          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: filtered.length + 1,
            itemBuilder: (context, i) {
              if (i == filtered.length) {
                if (productsAsync.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox.shrink();
              }
              return ProductCard(product: filtered[i]);
            },
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
      ),
    );
  }
}
