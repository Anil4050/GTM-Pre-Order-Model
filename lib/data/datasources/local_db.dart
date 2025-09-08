import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import '../../core/utils/datetime_utils.dart';
import '../../core/utils/logger.dart';
import 'hive_adapters.dart';


class LocalDb {
late Box<ProductModel> products;
late Box<StockSnapshotModel> stock;
late Box<OrderModel> orders;
late Box<QueueItemModel> queue;


Future<void> init() async {
products = await Hive.openBox<ProductModel>('products');
stock = await Hive.openBox<StockSnapshotModel>('stock');
orders = await Hive.openBox<OrderModel>('orders');
queue = await Hive.openBox<QueueItemModel>('queue');


if (products.isEmpty) {
final jsonStr = await rootBundle.loadString('assets/products_seed.json');
final arr = (json.decode(jsonStr) as List).cast<Map<String, dynamic>>();
for (final m in arr) {
await products.add(ProductModel(
id: m['id'], name: m['name'], unit: m['unit'], priceCents: m['priceCents'],
));
}
// initial stock for next day
final tomorrow = DateTimeUtils.ymd(DateTime.now().add(const Duration(days: 1)));
for (final p in products.values) {
await stock.add(StockSnapshotModel(productId: p.id, dateYmd: tomorrow, availableQty: 50));
}
Log.d('Seeded products & stock');
}
}
}