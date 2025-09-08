import 'hive_adapters.dart';
import 'local_db.dart';


class SyncQueueDataSource {
final LocalDb db;
SyncQueueDataSource(this.db);


Iterable<QueueItemModel> get items => db.queue.values;
Future<void> remove(QueueItemModel item) => item.delete();
}