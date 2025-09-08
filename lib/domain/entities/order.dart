import '../../core/constants/slots.dart';


enum OrderStatus { pending, queued, placed, cancelled }


class OrderEntity {
final String id;
final String productId;
final int quantity; // integer units
final DeliverySlot slot;
final DateTime serviceDate; // delivery date
final OrderStatus status;
const OrderEntity({
required this.id,
required this.productId,
required this.quantity,
required this.slot,
required this.serviceDate,
required this.status,
});
}