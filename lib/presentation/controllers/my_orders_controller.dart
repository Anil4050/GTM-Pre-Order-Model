import 'package:get/get.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/get_orders.dart';
import '../../../domain/usecases/cancel_order.dart';


class MyOrdersController extends GetxController {
final GetOrders getOrders;
final CancelOrder cancelOrder;
MyOrdersController(this.getOrders, this.cancelOrder);


final orders = <OrderEntity>[].obs;
final info = ''.obs;


@override
void onInit() { super.onInit(); refreshOrders(); }


Future<void> refreshOrders() async {
orders.assignAll(await getOrders());
}


Future<void> cancel(String id) async {
await cancelOrder(id);
info.value = 'Cancelled';
await refreshOrders();
}
}