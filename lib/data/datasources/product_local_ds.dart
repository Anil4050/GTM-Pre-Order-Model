import 'local_db.dart';
import '../../domain/entities/product.dart';


class ProductLocalDataSource {
final LocalDb db;
ProductLocalDataSource(this.db);


Future<List<Product>> getProducts({String? query, int limit = 20, int offset = 0}) async {
final list = db.products.values.where((p) {
if (query == null || query.isEmpty) return true;
return p.name.toLowerCase().contains(query.toLowerCase());
}).skip(offset).take(limit).map((p) => Product(id: p.id, name: p.name, unit: p.unit, priceCents: p.priceCents)).toList();
return list;
}
}