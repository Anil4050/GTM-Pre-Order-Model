import '../../services/sync_service.dart';


class ProcessOfflineQueue {
final SyncService syncService;
ProcessOfflineQueue(this.syncService);
Future<void> call() => syncService.processQueue();
}