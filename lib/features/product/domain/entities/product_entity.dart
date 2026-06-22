class ProductEntity {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String imageUrl;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.imageUrl,
  });

  double get priceWithDiscount =>
      price - (price * discountPercentage / 100);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'imageUrl': imageUrl,
    };
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      discountPercentage: (map['discountPercentage'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      stock: map['stock'] as int,
      brand: map['brand'] as String,
      category: map['category'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
