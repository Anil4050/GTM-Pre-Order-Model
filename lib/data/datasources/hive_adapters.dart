

import 'package:hive/hive.dart';
part 'hive_adapters.g.dart';


@HiveType(typeId: 1)
class ProductModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String unit;

  @HiveField(3)
  int priceCents;

  ProductModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.priceCents,
  });
}

@HiveType(typeId: 2)
class StockSnapshotModel extends HiveObject {
  @HiveField(0)
  String productId;

  @HiveField(1)
  String dateYmd;

  @HiveField(2)
  int availableQty;

  StockSnapshotModel({
    required this.productId,
    required this.dateYmd,
    required this.availableQty,
  });
}

@HiveType(typeId: 3)
class OrderModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String productId;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  int slotIndex; // 0,1,2

  @HiveField(4)
  String serviceDateYmd;

  @HiveField(5)
  int statusIndex; // 0..3

  OrderModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.slotIndex,
    required this.serviceDateYmd,
    required this.statusIndex,
  });
}

@HiveType(typeId: 4)
class QueueItemModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type; // 'place' | 'cancel' | 'stock'

  @HiveField(2)
  Map<String, dynamic> payload;

  @HiveField(3)
  int createdAt;

  QueueItemModel({
    required this.id,
    required this.type,
    required this.payload,
    required this.createdAt,
  });
}
