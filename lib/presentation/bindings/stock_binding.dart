import 'package:get/get.dart';
import '../../core/network/network_info.dart';
import '../../data/datasources/local_db.dart';
import '../../data/datasources/order_local_ds.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/usecases/update_stock.dart';
import '../controllers/stock_controller.dart';


class StockBinding extends Bindings {
@override
void dependencies() {
Get.lazyPut(() => NetworkInfo());
Get.lazyPut(() => LocalDb());
Get.putAsync(() async { final db = Get.find<LocalDb>(); await db.init(); return db; });
Get.lazyPut(() => OrderRepositoryImpl(OrderLocalDataSource(Get.find<LocalDb>())));
Get.lazyPut(() => UpdateStock(Get.find<OrderRepositoryImpl>()));
Get.lazyPut(() => StockController(Get.find<UpdateStock>()));
}
}