import 'package:get/get.dart';
import '../core/utils/logger.dart';
import '../data/datasources/local_db.dart';


class SeedService extends GetxService {
final LocalDb db;
SeedService(this.db);
Future<void> ensureSeeded() async {
// Already handled in LocalDb.init, keep placeholder for future.
Log.d('Seed checked');
}
}