import 'package:get/get.dart';


class NetworkInfo extends GetxService {
final _isConnected = true.obs; // toggle via debug panel
bool get isConnected => _isConnected.value;
void setConnected(bool val) => _isConnected.value = val;
}