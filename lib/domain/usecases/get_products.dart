import '../entities/product.dart';
import '../repositories/product_repository.dart';


class GetProducts {
final ProductRepository repo;
GetProducts(this.repo);
Future<List<Product>> call({String? query}) => repo.getProducts(query: query);
}