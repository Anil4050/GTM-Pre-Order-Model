import 'package:pre_order_mobile_app/core/errors/failures.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/slots.dart';
import '../../core/utils/datetime_utils.dart';
import '../../domain/entities/order.dart' as e;
import '../../domain/entities/stock_snapshot.dart' as e;
import 'hive_adapters.dart';
import 'local_db.dart';

class OrderLocalDataSource {
  final LocalDb db;
  final _uuid = const Uuid();
  OrderLocalDataSource(this.db);

  Future<void> updateStock({required String productId, required DateTime date, required int newAvailableQty}) async {
    final keyDate = DateTimeUtils.ymd(date);
    final existing = db.stock.values.firstWhere(
      (s) => s.productId == productId && s.dateYmd == keyDate,
      orElse: () => StockSnapshotModel(productId: productId, dateYmd: keyDate, availableQty: 0),
    );
    if (existing.isInBox) {
      existing.availableQty = newAvailableQty;
      await existing.save();
    } else {
      await db.stock.add(StockSnapshotModel(productId: productId, dateYmd: keyDate, availableQty: newAvailableQty));
    }
  }

  Future<List<e.StockSnapshot>> getStockForDate(DateTime date) async {
    final keyDate = DateTimeUtils.ymd(date);
    return db.stock.values
        .where((s) => s.dateYmd == keyDate)
        .map((s) => e.StockSnapshot(productId: s.productId, date: date, availableQty: s.availableQty))
        .toList();
  }

  Future<e.OrderEntity> placeOrder({
    required String productId,
    required int quantity,
    required DeliverySlot slot,
    required DateTime serviceDate,
    bool queueIfOffline = false,
  }) async {
    // check stock
    final keyDate = DateTimeUtils.ymd(serviceDate);
    final stock = db.stock.values.firstWhere(
      (s) => s.productId == productId && s.dateYmd == keyDate,
      orElse: () => throw StockFailure('No stock snapshot for service date'),
    );
    if (stock.availableQty < quantity) {
      throw StockFailure('Insufficient stock');
    }
    // reserve
    stock.availableQty -= quantity;
    await stock.save();

    final order = OrderModel(
      id: _uuid.v4(),
      productId: productId,
      quantity: quantity,
      slotIndex: slot.index,
      serviceDateYmd: keyDate,
      statusIndex: e.OrderStatus.pending.index,
    );
    await db.orders.add(order);

    // enqueue for sync
    await db.queue.add(QueueItemModel(
      id: _uuid.v4(),
      type: 'place',
      payload: {
        'orderId': order.id,
      },
      createdAt: DateTime.now().millisecondsSinceEpoch,
    ));

    return e.OrderEntity(
      id: order.id,
      productId: order.productId,
      quantity: order.quantity,
      slot: DeliverySlot.values[order.slotIndex],
      serviceDate: serviceDate,
      status: e.OrderStatus.pending,
    );
  }

  Future<void> cancelOrder(String orderId) async {
    final order = db.orders.values.firstWhere((o) => o.id == orderId);
    if (order.statusIndex == e.OrderStatus.cancelled.index) return;
    // restore stock
    final snap = db.stock.values.firstWhere((s) => s.productId == order.productId && s.dateYmd == order.serviceDateYmd);
    snap.availableQty += order.quantity;
    await snap.save();

    order.statusIndex = e.OrderStatus.cancelled.index;
    await order.save();

    await db.queue.add(QueueItemModel(
      id: const Uuid().v4(),
      type: 'cancel',
      payload: {'orderId': orderId},
      createdAt: DateTime.now().millisecondsSinceEpoch,
    ));
  }

  Future<List<e.OrderEntity>> getOrders({int limit = 50, int offset = 0}) async {
    return db.orders.values
        .skip(offset)
        .take(limit)
        .map((o) => e.OrderEntity(
              id: o.id,
              productId: o.productId,
              quantity: o.quantity,
              slot: DeliverySlot.values[o.slotIndex],
              serviceDate: DateTime.parse(o.serviceDateYmd),
              status: e.OrderStatus.values[o.statusIndex],
            ))
        .toList();
  }
}
