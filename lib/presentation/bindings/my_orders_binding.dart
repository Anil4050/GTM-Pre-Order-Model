import 'package:get/get.dart';
import '../../data/datasources/local_db.dart';
import '../../data/datasources/order_local_ds.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/usecases/get_orders.dart';
import '../../domain/usecases/cancel_order.dart';
import '../controllers/my_orders_controller.dart';


class MyOrdersBinding extends Bindings {
@override
void dependencies() {
Get.lazyPut(() => OrderRepositoryImpl(OrderLocalDataSource(Get.find<LocalDb>())));
Get.lazyPut(() => GetOrders(Get.find<OrderRepositoryImpl>()));
Get.lazyPut(() => CancelOrder(Get.find<OrderRepositoryImpl>()));
Get.lazyPut(() => MyOrdersController(Get.find<GetOrders>(), Get.find<CancelOrder>()));
}
}