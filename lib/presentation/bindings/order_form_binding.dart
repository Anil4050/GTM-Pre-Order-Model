import 'package:get/get.dart';
import '../../data/datasources/local_db.dart';
import '../../data/datasources/product_local_ds.dart';
import '../../data/datasources/order_local_ds.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/place_order.dart';
import '../controllers/order_form_controller.dart';


class OrderFormBinding extends Bindings {
@override
void dependencies() {
Get.lazyPut(() => ProductRepositoryImpl(ProductLocalDataSource(Get.find<LocalDb>())));
Get.lazyPut(() => OrderRepositoryImpl(OrderLocalDataSource(Get.find<LocalDb>())));
Get.lazyPut(() => GetProducts(Get.find<ProductRepositoryImpl>()));
Get.lazyPut(() => PlaceOrder(Get.find<OrderRepositoryImpl>()));
Get.lazyPut(() => OrderFormController(Get.find<GetProducts>(), Get.find<PlaceOrder>()));
}
}