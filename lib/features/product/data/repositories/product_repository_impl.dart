import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/data/sources/local_product_source.dart';
import 'package:ecommerce_app/features/product/data/sources/remote_product_source.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteProductSource remoteProductSource;
  final LocalProductSource localProductSource;

  ProductRepositoryImpl({
    required this.remoteProductSource,
    required this.localProductSource,
  });

  @override
  Future<List<ProductEntity>> getAllProducts(int skip, int limit) async {
    final remoteList = await remoteProductSource.getAllProducts(skip, limit);
    return remoteList.map((p) => p.toEntity()).toList();
  }

  @override
  Future<ProductEntity> getProductById(int id) async {
    final remote = await remoteProductSource.getProductById(id);
    return remote.toEntity();
  }

  @override
  Future<List<String>> getCategories() async {
    return await remoteProductSource.getCategories();
  }

  @override
  Future<void> saveToCart(ProductEntity product) async {
    await localProductSource.insertCartItem(product);
  }

  @override
  Future<bool> removeFromCart(int id) async {
    final rows = await localProductSource.deleteCartItem(id);
    return rows == 1;
  }

  @override
  Future<List<ProductEntity>> getAllCartItems() async {
    return await localProductSource.getAllCartItems();
  }
}
