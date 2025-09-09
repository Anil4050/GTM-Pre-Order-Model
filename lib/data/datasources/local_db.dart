// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:hive/hive.dart';
// import '../../core/utils/datetime_utils.dart';
// import '../../core/utils/logger.dart';
// import 'hive_adapters.dart';


// class LocalDb {
// late Box<ProductModel> products;
// late Box<StockSnapshotModel> stock;
// late Box<OrderModel> orders;
// late Box<QueueItemModel> queue;


// Future<void> init() async {
// products = await Hive.openBox<ProductModel>('products');
// stock = await Hive.openBox<StockSnapshotModel>('stock');
// orders = await Hive.openBox<OrderModel>('orders');
// queue = await Hive.openBox<QueueItemModel>('queue');


// if (products.isEmpty) {
// final jsonStr = await rootBundle.loadString('assets/products_seed.json');
// final arr = (json.decode(jsonStr) as List).cast<Map<String, dynamic>>();
// for (final m in arr) {
// await products.add(ProductModel(
// id: m['id'], name: m['name'], unit: m['unit'], priceCents: m['priceCents'],
// ));
// }
// // initial stock for next day
// final tomorrow = DateTimeUtils.ymd(DateTime.now().add(const Duration(days: 1)));
// for (final p in products.values) {
// await stock.add(StockSnapshotModel(productId: p.id, dateYmd: tomorrow, availableQty: 50));
// }
// Log.d('Seeded products & stock');
// }
// }
// }
import 'package:hive/hive.dart';
import 'package:pre_order_mobile_app/data/models/order_model.dart';
import 'package:pre_order_mobile_app/data/models/product_model.dart';
import 'package:pre_order_mobile_app/data/models/queue_item_model.dart';
import 'package:pre_order_mobile_app/data/models/stock_snapshot_model.dart';

class LocalDb {
  late Box<ProductModel> products;
  late Box<StockSnapshotModel> stockSnapshots;
  late Box<OrderModel> orders;
  late Box<QueueItemModel> queue;

  Future<void> init() async {
    products = await Hive.openBox<ProductModel>('products');
    stockSnapshots = await Hive.openBox<StockSnapshotModel>('stockSnapshots');
    orders = await Hive.openBox<OrderModel>('orders');
    queue = await Hive.openBox<QueueItemModel>('queue');

    // 👇 Seed products only if DB empty
    if (products.isEmpty) {
      final defaults = [
        ProductModel(id: '1', name: 'Tomato', unit: 'kg', priceCents: 3000, stock: 50),
        ProductModel(id: '2', name: 'Potato', unit: 'kg', priceCents: 2000, stock: 80),
        ProductModel(id: '3', name: 'Onion', unit: 'kg', priceCents: 2500, stock: 70),
        ProductModel(id: '4', name: 'Carrot', unit: 'kg', priceCents: 4000, stock: 40),
        ProductModel(id: '5', name: 'Cabbage', unit: 'kg', priceCents: 3500, stock: 30),
      ];

      for (final p in defaults) {
        await products.put(p.id, p);
      }
    }
  }
}
