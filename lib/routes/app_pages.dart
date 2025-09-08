import 'package:get/get.dart';
import 'package:pre_order_mobile_app/presentation/bindings/my_orders_binding.dart';
import 'package:pre_order_mobile_app/presentation/bindings/order_form_binding.dart';
import 'package:pre_order_mobile_app/presentation/bindings/stock_binding.dart';
import 'package:pre_order_mobile_app/presentation/pages/my_orders_page.dart';
import 'package:pre_order_mobile_app/presentation/pages/pre_order_form_page.dart';
import 'package:pre_order_mobile_app/presentation/pages/stock_page.dart';


class AppRoutes {
static const stock = '/';
static const orderForm = '/order';
static const myOrders = '/orders';
}


final pages = [
GetPage(name: AppRoutes.stock, page: () => const StockPage(), binding: StockBinding()),
GetPage(name: AppRoutes.orderForm, page: () => const PreOrderFormPage(), binding: OrderFormBinding()),
GetPage(name: AppRoutes.myOrders, page: () => const MyOrdersPage(), binding: MyOrdersBinding()),
];