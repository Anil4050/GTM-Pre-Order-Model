import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pre_order_mobile_app/core/errors/failures.dart';
import '../../../core/constants/slots.dart';
import '../../../core/utils/datetime_utils.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../domain/usecases/place_order.dart';

class OrderFormController extends GetxController {
  final GetProducts getProducts;
  final PlaceOrder placeOrder;
  OrderFormController(this.getProducts, this.placeOrder);

  final products = <Product>[].obs;
  final query = ''.obs;
  final selectedProduct = Rxn<Product>();
  final quantity = 1.obs;
  final selectedSlot = DeliverySlot.morning.obs;
  final info = ''.obs;

  final qtyController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    search();
    qtyController.text = quantity.value.toString();
    qtyController.addListener(() {
      final q = int.tryParse(qtyController.text) ?? 1;
      quantity.value = q;
    });
  }

  Future<void> search([String? q]) async {
    final res = await getProducts(query: q ?? query.value);
    products.assignAll(res);
  }

  String get serviceDateLabel =>
      DateTimeUtils.ymd(DateTimeUtils.serviceDateForOrder(DateTime.now()));

  Future<void> submit() async {
    final p = selectedProduct.value;
    if (p == null) {
      info.value = 'Please select a product';
      return;
    }

    try {
      final order = await placeOrder(
        productId: p.id,
        quantity: quantity.value,
        slot: selectedSlot.value,
      );
      info.value =
          'Order placed #${order.id.substring(0, 6)} for ${p.name} on $serviceDateLabel';
    } on Failure catch (f) {
      // Any custom Failure (StockFailure, NetworkFailure, etc.)
      info.value = f.message;
      // optional: show a snackbar too
      Get.snackbar(
        'Order error',
        f.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // Unexpected error
      info.value = 'Unexpected error, please try again';
      // Log for debugging
      // Log.e('placeOrder error', e, st);
      Get.snackbar('Error', 'Unexpected error, see logs');
    }
  }

  @override
  void onClose() {
    qtyController.dispose();
    super.onClose();
  }
}
