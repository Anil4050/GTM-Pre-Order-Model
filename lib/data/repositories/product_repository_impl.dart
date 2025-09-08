import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_ds.dart';


class ProductRepositoryImpl implements ProductRepository {
final ProductLocalDataSource ds;
ProductRepositoryImpl(this.ds);
@override
Future<List<Product>> getProducts({String? query, int limit = 20, int offset = 0}) {
return ds.getProducts(query: query, limit: limit, offset: offset);
}
}