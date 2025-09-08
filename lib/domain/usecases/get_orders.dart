import '../entities/order.dart';
import '../repositories/order_repository.dart';


class GetOrders {
final OrderRepository repo;
GetOrders(this.repo);
Future<List<OrderEntity>> call() => repo.getOrders();
}