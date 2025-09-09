import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pre_order_mobile_app/routes/app_pages.dart';
import 'core/network/network_info.dart';
import 'data/datasources/hive_adapters.dart';
import 'data/datasources/local_db.dart';
import 'presentation/theme/app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(StockSnapshotModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  Hive.registerAdapter(QueueItemModelAdapter());

  Get.put(NetworkInfo());
  final db = Get.put(LocalDb());
  await db.init();

  runApp(const EAApp());
}


class EAApp extends StatelessWidget {
const EAApp({super.key});
@override
Widget build(BuildContext context) {
return GetMaterialApp(
title: 'EA Foods Pre‑Order',
theme: appTheme(),
getPages: pages,
initialRoute: AppRoutes.stock,
);
}
}