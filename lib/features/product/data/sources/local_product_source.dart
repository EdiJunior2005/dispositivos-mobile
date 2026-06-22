import 'package:sqflite/sqflite.dart';
import 'package:ecommerce_app/core/database/database_helper.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

class LocalProductSource {
  final DatabaseHelper databaseHelper;

  LocalProductSource({required this.databaseHelper});

  Future<int> insertCartItem(ProductEntity product) async {
    final db = await databaseHelper.database;
    return await db.insert(
      'carrinho',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductEntity>> getAllCartItems() async {
    final db = await databaseHelper.database;
    final result = await db.query('carrinho');
    return result.map((map) => ProductEntity.fromMap(map)).toList();
  }

  Future<int> deleteCartItem(int id) async {
    final db = await databaseHelper.database;
    return await db.delete('carrinho', where: 'id = ?', whereArgs: [id]);
  }
}
