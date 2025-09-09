import 'package:hive/hive.dart';

part 'stock_snapshot_model.g.dart';

@HiveType(typeId: 1)
class StockSnapshotModel extends HiveObject {
  @HiveField(0)
  final String productId;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final int stock;

  StockSnapshotModel({
    required this.productId,
    required this.timestamp,
    required this.stock,
  });
}
