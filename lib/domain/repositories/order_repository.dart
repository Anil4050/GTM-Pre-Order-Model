import '../entities/order.dart';
import '../entities/stock_snapshot.dart';
import '../../core/constants/slots.dart';


abstract class OrderRepository {
Future<void> updateStock({required String productId, required DateTime date, required int newAvailableQty});
Future<List<StockSnapshot>> getStockForDate(DateTime date);


Future<OrderEntity> placeOrder({
required String productId,
required int quantity,
required DeliverySlot slot,
required DateTime serviceDate,
});


Future<void> cancelOrder(String orderId);
Future<List<OrderEntity>> getOrders({int limit = 50, int offset = 0});
}