import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/core/database/database_helper.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/data/sources/local_product_source.dart';
import 'package:ecommerce_app/features/product/data/sources/remote_product_source.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';


final dioProvider = Provider<Dio>((ref) => Dio());

final databaseHelperProvider = Provider<DatabaseHelper>(
  (ref) => DatabaseHelper.instance,
);

final localProductSourceProvider = Provider<LocalProductSource>((ref) {
  return LocalProductSource(databaseHelper: ref.watch(databaseHelperProvider));
});

final remoteProductSourceProvider = Provider<RemoteProductSource>((ref) {
  return RemoteProductSource(dio: ref.watch(dioProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    localProductSource: ref.watch(localProductSourceProvider),
    remoteProductSource: ref.watch(remoteProductSourceProvider),
  );
});

class SelectedCategoryNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String? category) => state = category;
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, String?>(
      SelectedCategoryNotifier.new,
    );

class ProductListNotifier extends AsyncNotifier<List<ProductEntity>> {
  int _skip = 0;
  static const int _pageSize = 20;

  int get skip => _skip;

  @override
  Future<List<ProductEntity>> build() async {
    _skip = 0;
    final repo = ref.watch(productRepositoryProvider);
    return repo.getAllProducts(0, _pageSize);
  }

  Future<void> loadMore() async {
    final current = <ProductEntity>[...state.value ?? []];
    final repo = ref.watch(productRepositoryProvider);
    _skip += _pageSize;
    final more = await repo.getAllProducts(_skip, _pageSize);
    current.addAll(more);
    state = AsyncData(current);
  }
}

final productListProvider =
    AsyncNotifierProvider<ProductListNotifier, List<ProductEntity>>(
      () => ProductListNotifier(),
    );

final categoriesProvider = FutureProvider<List<String>>((ref) {
  return ref.watch(productRepositoryProvider).getCategories();
});

class CartNotifier extends AsyncNotifier<List<ProductEntity>> {
  @override
  Future<List<ProductEntity>> build() async {
    final repo = ref.watch(productRepositoryProvider);
    return repo.getAllCartItems();
  }

  Future<void> add(ProductEntity product) async {
    final repo = ref.watch(productRepositoryProvider);
    await repo.saveToCart(product);
    state = AsyncData(await repo.getAllCartItems());
  }

  Future<bool> remove(int id) async {
    final repo = ref.watch(productRepositoryProvider);
    final ok = await repo.removeFromCart(id);
    state = AsyncData(await repo.getAllCartItems());
    return ok;
  }
}

final cartProvider = AsyncNotifierProvider<CartNotifier, List<ProductEntity>>(
  () => CartNotifier(),
);


final productDetailProvider = FutureProvider.autoDispose
    .family<ProductEntity, int>((ref, id) {
      return ref.watch(productRepositoryProvider).getProductById(id);
    });
