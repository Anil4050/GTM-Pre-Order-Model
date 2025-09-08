import '../repositories/order_repository.dart';


class UpdateStock {
final OrderRepository repo;
UpdateStock(this.repo);
Future<void> call({required String productId, required DateTime date, required int availableQty})
=> repo.updateStock(productId: productId, date: date, newAvailableQty: availableQty);
}