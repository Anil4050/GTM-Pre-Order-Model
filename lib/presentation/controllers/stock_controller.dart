import 'package:get/get.dart';
import '../../../core/utils/datetime_utils.dart';
import '../../../domain/usecases/update_stock.dart';


class StockController extends GetxController {
final UpdateStock updateStock;
StockController(this.updateStock);


final isLoading = false.obs;
final message = ''.obs;


Future<void> setStock({required String productId, required int qty, DateTime? forDate}) async {
isLoading.value = true;
try {
await updateStock(
productId: productId,
date: forDate ?? DateTimeUtils.serviceDateForOrder(DateTime.now()).subtract(const Duration(days: 1)),
availableQty: qty,
);
message.value = 'Stock updated';
} catch (e) {
message.value = 'Error: $e';
} finally {
isLoading.value = false;
}
}
}