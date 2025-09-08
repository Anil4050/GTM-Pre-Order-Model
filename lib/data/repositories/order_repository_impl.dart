import '../../core/constants/slots.dart';
import '../../domain/entities/order.dart' as e;
import '../../domain/entities/stock_snapshot.dart' as e;
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_local_ds.dart';


class OrderRepositoryImpl implements OrderRepository {
final OrderLocalDataSource ds;
OrderRepositoryImpl(this.ds);


@override
Future<void> updateStock({required String productId, required DateTime date, required int newAvailableQty})
=> ds.updateStock(productId: productId, date: date, newAvailableQty: newAvailableQty);


@override
Future<List<e.StockSnapshot>> getStockForDate(DateTime date) => ds.getStockForDate(date);


@override
Future<e.OrderEntity> placeOrder({required String productId, required int quantity, required DeliverySlot slot, required DateTime serviceDate})
=> ds.placeOrder(productId: productId, quantity: quantity, slot: slot, serviceDate: serviceDate);


@override
Future<void> cancelOrder(String orderId) => ds.cancelOrder(orderId);


@override
Future<List<e.OrderEntity>> getOrders({int limit = 50, int offset = 0}) => ds.getOrders(limit: limit, offset: offset);
}