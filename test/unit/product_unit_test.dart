import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';

void main() {
  // ── Helpers ────────────────────────────────────────────────────────────────

  ProductEntity makeProduct({
    int id = 1,
    String title = 'Produto Teste',
    double price = 100.0,
    double discountPercentage = 10.0,
    double rating = 4.5,
    int stock = 50,
    String category = 'electronics',
    String brand = 'MarcaX',
  }) {
    return ProductEntity(
      id: id,
      title: title,
      description: 'Descrição do produto',
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      brand: brand,
      category: category,
      imageUrl: 'https://example.com/img.jpg',
    );
  }

  // ── Teste 1: JSON → Model ──────────────────────────────────────────────────

  group('ProductModel.fromJson', () {
    test('deve mapear corretamente um JSON válido', () {
      final json = {
        'id': 1,
        'title': 'iPhone 9',
        'description': 'An apple mobile',
        'price': 549.99,
        'discountPercentage': 12.96,
        'rating': 4.69,
        'stock': 94,
        'brand': 'Apple',
        'category': 'smartphones',
        'thumbnail': 'https://i.dummyjson.com/img/1/thumbnail.jpg',
      };

      final model = ProductModel.fromJson(json);

      expect(model.id, 1);
      expect(model.title, 'iPhone 9');
      expect(model.price, 549.99);
      expect(model.brand, 'Apple');
      expect(model.category, 'smartphones');
    });
  });

  // ── Teste 2: Model → Entity ────────────────────────────────────────────────

  group('ProductModel.toEntity', () {
    test('deve converter ProductModel para ProductEntity corretamente', () {
      final model = ProductModel(
        id: 2,
        title: 'Camisa Polo',
        description: 'Camisa azul',
        price: 79.90,
        discountPercentage: 5.0,
        rating: 3.8,
        stock: 20,
        brand: 'FashionBR',
        category: "men's clothing",
        imageUrl: 'https://example.com/camisa.jpg',
      );

      final entity = model.toEntity();

      expect(entity.id, 2);
      expect(entity.title, 'Camisa Polo');
      expect(entity.price, 79.90);
      expect(entity.category, "men's clothing");
    });
  });

  // ── Teste 3: Cálculo de preço com desconto ─────────────────────────────────

  group('ProductEntity.priceWithDiscount', () {
    test('deve calcular preço final corretamente com desconto', () {
      final product = makeProduct(price: 200.0, discountPercentage: 25.0);

      expect(product.priceWithDiscount, closeTo(150.0, 0.01));
    });

    test('deve retornar preço original quando desconto é zero', () {
      final product = makeProduct(price: 100.0, discountPercentage: 0.0);

      expect(product.priceWithDiscount, 100.0);
    });
  });

  // ── Teste 4: Entity → Map → Entity (round-trip SQLite) ────────────────────

  group('ProductEntity serialization', () {
    test('toMap e fromMap devem preservar todos os campos', () {
      final original = makeProduct();
      final map = original.toMap();
      final restored = ProductEntity.fromMap(map);

      expect(restored.id, original.id);
      expect(restored.title, original.title);
      expect(restored.price, original.price);
      expect(restored.discountPercentage, original.discountPercentage);
      expect(restored.rating, original.rating);
      expect(restored.stock, original.stock);
      expect(restored.brand, original.brand);
      expect(restored.category, original.category);
      expect(restored.imageUrl, original.imageUrl);
    });
  });

  // ── Teste 5: Ordenação de produtos por preço ───────────────────────────────

  group('Ordenação de produtos', () {
    test('deve ordenar lista de produtos por preço crescente', () {
      final products = [
        makeProduct(id: 1, price: 300.0),
        makeProduct(id: 2, price: 50.0),
        makeProduct(id: 3, price: 150.0),
      ];

      final sorted = [...products]
        ..sort((a, b) => a.priceWithDiscount.compareTo(b.priceWithDiscount));

      expect(sorted[0].price, 50.0);
      expect(sorted[1].price, 150.0);
      expect(sorted[2].price, 300.0);
    });

    test('deve filtrar produtos por categoria', () {
      final products = [
        makeProduct(id: 1, category: 'electronics'),
        makeProduct(id: 2, category: 'clothing'),
        makeProduct(id: 3, category: 'electronics'),
      ];

      final electronics =
          products.where((p) => p.category == 'electronics').toList();

      expect(electronics.length, 2);
      expect(electronics.every((p) => p.category == 'electronics'), isTrue);
    });
  });
}
