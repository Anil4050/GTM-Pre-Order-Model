import 'package:pre_order_mobile_app/core/errors/failures.dart';

import '../../core/constants/slots.dart';
import '../../core/utils/datetime_utils.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';


class PlaceOrder {
final OrderRepository repo;
PlaceOrder(this.repo);


Future<OrderEntity> call({
required String productId,
required int quantity,
required DeliverySlot slot,
DateTime? now,
}) async {
final current = now ?? DateTime.now();
final serviceDate = DateTimeUtils.serviceDateForOrder(current);
if (quantity <= 0) {
throw StockFailure('Quantity must be > 0');
}
return repo.placeOrder(
productId: productId,
quantity: quantity,
slot: slot,
serviceDate: serviceDate,
);
}
}