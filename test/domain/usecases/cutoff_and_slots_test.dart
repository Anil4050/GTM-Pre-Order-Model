import 'package:flutter_test/flutter_test.dart';
import 'package:pre_order_mobile_app/core/constants/slots.dart';


void main() {
test('delivery slots labels', () {
expect(DeliverySlot.morning.label.contains('8'), true);
expect(DeliverySlot.afternoon.label.contains('12'), true);
expect(DeliverySlot.evening.label.contains('4'), true);
});
}