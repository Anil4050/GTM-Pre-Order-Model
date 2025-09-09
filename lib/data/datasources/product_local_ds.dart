import 'package:pre_order_mobile_app/data/datasources/local_db.dart';
import 'package:pre_order_mobile_app/domain/entities/product.dart';

class ProductLocalDataSource {
  final LocalDb db;
  ProductLocalDataSource(this.db);

  Future<List<Product>> getProducts({String? query, int limit = 20, int offset = 0}) async {
    final list = db.products.values.where((p) {
      if (query == null || query.isEmpty) return true;
      return p.name.toLowerCase().contains(query.toLowerCase());
    }).skip(offset).take(limit).map(
      (p) => Product(
        id: p.id,
        name: p.name,
        unit: p.unit,
        priceCents: p.priceCents,
      ),
    ).toList();
    return list;
  }

  /// 👇 New: Get product by id
  Future<Product?> getProduct(String id) async {
    final p = db.products.get(id);
    if (p == null) return null;
    return Product(id: p.id, name: p.name, unit: p.unit, priceCents: p.priceCents);
  }

  /// 👇 New: Update stock
  Future<void> updateStock(String id, int newStock) async {
    final product = db.products.get(id);
    if (product != null) {
      final updated = product.copyWith(stock: newStock);
      await db.products.put(id, updated);
    }
  }
}
