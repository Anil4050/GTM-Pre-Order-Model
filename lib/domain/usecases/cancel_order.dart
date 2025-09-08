import '../repositories/order_repository.dart';


class CancelOrder {
final OrderRepository repo;
CancelOrder(this.repo);
Future<void> call(String orderId) => repo.cancelOrder(orderId);
}