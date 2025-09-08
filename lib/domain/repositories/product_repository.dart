import '../entities/product.dart';


abstract class ProductRepository {
Future<List<Product>> getProducts({String? query, int limit = 20, int offset = 0});
}