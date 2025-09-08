import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pre_order_mobile_app/routes/app_pages.dart';
import '../../core/constants/slots.dart';
import '../../domain/entities/order.dart';
import '../controllers/my_orders_controller.dart';


class MyOrdersPage extends StatelessWidget {
const MyOrdersPage({super.key});


@override
Widget build(BuildContext context) {
final c = Get.find<MyOrdersController>();
return Scaffold(
appBar: AppBar(title: const Text('My Orders')),
bottomNavigationBar: NavigationBar(
selectedIndex: 2,
onDestinationSelected: (i) {
if (i == 0) Get.toNamed(AppRoutes.stock);
if (i == 1) Get.toNamed(AppRoutes.orderForm);
},
destinations: const [
NavigationDestination(icon: Icon(Icons.inventory), label: 'Stock'),
NavigationDestination(icon: Icon(Icons.add_shopping_cart), label: 'Pre‑Order'),
NavigationDestination(icon: Icon(Icons.list_alt), label: 'My Orders'),
],
),
body: Obx(() => ListView.separated(
padding: const EdgeInsets.all(16),
itemBuilder: (_, i) {
final o = c.orders[i];
return ListTile(
title: Text('Order #${o.id.substring(0,6)} – ${o.productId} x${o.quantity}'),
subtitle: Text('${o.slot.label} on ${o.serviceDate.toIso8601String().substring(0,10)} – ${o.status.name}'),
trailing: o.status == OrderStatus.cancelled ? null : TextButton(
onPressed: () => c.cancel(o.id), child: const Text('Cancel')),
);
},
separatorBuilder: (_, __) => const Divider(),
itemCount: c.orders.length,
)),
floatingActionButton: FloatingActionButton(onPressed: c.refreshOrders, child: const Icon(Icons.refresh)),
);
}
}