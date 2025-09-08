import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pre_order_mobile_app/routes/app_pages.dart';
import '../../core/utils/datetime_utils.dart';
import '../controllers/stock_controller.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final c = Get.find<StockController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Ops – Stock View')),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          if (i == 1) Get.toNamed(AppRoutes.orderForm);
          if (i == 2) Get.toNamed(AppRoutes.myOrders);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.inventory), label: 'Stock'),
          NavigationDestination(icon: Icon(Icons.add_shopping_cart), label: 'Pre‑Order'),
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'My Orders'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service Date: ${DateTimeUtils.ymd(DateTime.now().add(const Duration(days: 1)))}'),
            const SizedBox(height: 12),
            _StockEditor(),
          ],
        ),
      ),
    );
  }
}

class _StockEditor extends StatefulWidget {
  @override
  State<_StockEditor> createState() => _StockEditorState();
}

class _StockEditorState extends State<_StockEditor> {
  final _formKey = GlobalKey<FormState>();
  final _productIdCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController(text: '50');

  @override
  Widget build(BuildContext context) {
    final c = Get.find<StockController>();
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(controller: _productIdCtrl, decoration: const InputDecoration(labelText: 'Product ID'), validator: (v) => (v==null||v.isEmpty)?'Required':null),
        const SizedBox(height: 8),
        TextFormField(controller: _qtyCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Available Qty'), validator: (v)=> (v==null||int.tryParse(v)==null)?'Number required':null),
        const SizedBox(height: 12),
        Obx(() => ElevatedButton(
          onPressed: c.isLoading.value? null : () async {
            if(!_formKey.currentState!.validate()) return;
            await c.setStock(productId: _productIdCtrl.text, qty: int.parse(_qtyCtrl.text));
            // ignore: use_build_context_synchronously
            if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(c.message.value)));
          },
          child: c.isLoading.value ? const CircularProgressIndicator() : const Text('Update Stock (8AM/6PM)'),
        )),
      ]),
    );
  }
}
