import 'package:get/get.dart';
import '../core/network/network_info.dart';
import '../core/utils/logger.dart';
import '../data/datasources/sync_queue_ds.dart';
import '../data/datasources/hive_adapters.dart';


class SyncService extends GetxService {
final SyncQueueDataSource queue;
final NetworkInfo network;
SyncService(this.queue, this.network);


Future<void> processQueue() async {
if (!network.isConnected) return;
final items = List<QueueItemModel>.from(queue.items);
for (final item in items) {
// Simulate success immediately; in real impl, call API
Log.d('Synced ${item.type} ${item.id}');
await queue.remove(item);
}
}
}