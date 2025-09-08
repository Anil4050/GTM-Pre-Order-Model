import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pre_order_mobile_app/routes/app_pages.dart';
import '../../core/constants/slots.dart';
import '../controllers/order_form_controller.dart';


class PreOrderFormPage extends StatelessWidget {
  const PreOrderFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OrderFormController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Pre-Order')),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (i) {
          if (i == 0) Get.toNamed(AppRoutes.stock);
          if (i == 2) Get.toNamed(AppRoutes.myOrders);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.inventory), label: 'Stock'),
          NavigationDestination(icon: Icon(Icons.add_shopping_cart), label: 'Pre-Order'),
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'My Orders'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              TextField(
                onChanged: (v) => c.search(v),
                decoration: const InputDecoration(labelText: 'Search product'),
              ),
              const SizedBox(height: 8),

             
              SizedBox(
                height: 300,
                child: Obx(() => ListView.builder(
                      itemCount: c.products.length,
                      itemBuilder: (_, i) {
                        final p = c.products[i];
                        return RadioListTile(
                          title: Text(
                              '${p.name} (₹${(p.priceCents / 100).toStringAsFixed(2)}/${p.unit})'),
                          value: p,
                          groupValue: c.selectedProduct.value,
                          onChanged: (val) => c.selectedProduct.value = val,
                        );
                      },
                    )),
              ),
              const SizedBox(height: 8),

             
              Row(
                children: [
                  const Text('Qty'),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: c.qtyController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Spacer(),
                  const Text('Slot'),
                  const SizedBox(width: 8),
                  Obx(() => DropdownButton<DeliverySlot>(
                        value: c.selectedSlot.value,
                        items: DeliverySlot.values
                            .map((s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(s.label),
                                ))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) c.selectedSlot.value = v;
                        },
                      )),
                ],
              ),
              const SizedBox(height: 8),

             
              Text('Service Date: ${c.serviceDateLabel}'),
              const SizedBox(height: 8),

             
              ElevatedButton(
                onPressed: () => c.submit(),
                child: const Text('Place Order'),
              ),
              const SizedBox(height: 8),

            
              Obx(() => Text(c.info.value)),
            ],
          ),
        ),
      ),
    );
  }
}
