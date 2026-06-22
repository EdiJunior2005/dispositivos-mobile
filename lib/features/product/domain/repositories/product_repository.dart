import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getAllProducts(int skip, int limit);
  Future<ProductEntity> getProductById(int id);
  Future<List<String>> getCategories();

  Future<void> saveToCart(ProductEntity product);
  Future<bool> removeFromCart(int id);
  Future<List<ProductEntity>> getAllCartItems();
}
