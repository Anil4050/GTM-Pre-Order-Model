import 'package:hive/hive.dart';

part 'queue_item_model.g.dart';

@HiveType(typeId: 3)
class QueueItemModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String action; // place_order, cancel_order

  @HiveField(2)
  final Map<String, dynamic> payload;

  QueueItemModel({
    required this.id,
    required this.action,
    required this.payload,
  });
}
