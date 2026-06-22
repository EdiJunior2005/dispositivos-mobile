import 'package:dio/dio.dart';
import '../models/product_model.dart';

class RemoteProductSource {
  final Dio dio;

  RemoteProductSource({required this.dio});

  Future<List<ProductModel>> getAllProducts(int skip, int limit) async {
    try {
      final response = await dio.get(
        'https://dummyjson.com/products',
        queryParameters: {'limit': limit, 'skip': skip},
      );

      if (response.statusCode == 200 && response.data is Map) {
        final List products = response.data['products'];
        return products
            .map((p) => ProductModel.fromJson(p as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } on DioException catch (e) {
      throw Exception('getProdutos: ${e.message}');
    } catch (e) {
      throw Exception('getProdutos: $e');
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dio.get('https://dummyjson.com/products/$id');

      if (response.statusCode == 200 && response.data is Map) {
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } on DioException catch (e) {
      throw Exception('getProdutoPorId: ${e.message}');
    } catch (e) {
      throw Exception('getProdutoPorId: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response =
          await dio.get('https://dummyjson.com/products/category-list');

      if (response.statusCode == 200 && response.data is List) {
        return List<String>.from(response.data as List);
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } on DioException catch (e) {
      throw Exception('getCategorias: ${e.message}');
    } catch (e) {
      throw Exception('getCategorias: $e');
    }
  }
}
