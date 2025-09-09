import 'package:hive/hive.dart';

part 'order_model.g.dart';

@HiveType(typeId: 2)
class OrderModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productId;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String slot;

  @HiveField(5)
  final String status; // placed, cancelled, pending_sync, etc.

  OrderModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.date,
    required this.slot,
    required this.status,
  });
}
