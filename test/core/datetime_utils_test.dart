import 'package:flutter_test/flutter_test.dart';
import 'package:pre_order_mobile_app/core/utils/datetime_utils.dart';


void main() {
test('cutoff pushes +2 days after 18:00', () {
final dt = DateTime(2025, 9, 8, 18, 0);
final svc = DateTimeUtils.serviceDateForOrder(dt);
expect(svc.difference(DateTime(2025,9,8)).inDays, 2);
});
test('before cutoff is +1 day', () {
final dt = DateTime(2025, 9, 8, 17, 59);
final svc = DateTimeUtils.serviceDateForOrder(dt);
expect(svc.difference(DateTime(2025,9,8)).inDays, 1);
});
}