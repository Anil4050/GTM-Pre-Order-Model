import 'package:intl/intl.dart';
import '../constants/app_constants.dart';
import '../constants/slots.dart';

class DateTimeUtils {
  static bool isAfterCutoff(DateTime now) {
    return now.hour >= AppConstants.cutoffHour;
  }

  static DateTime serviceDateForOrder(DateTime now) {
    // Orders after 18:00 go +2 days; otherwise +1 day
    if (isAfterCutoff(now)) {
      return DateTime(now.year, now.month, now.day).add(const Duration(days: 2));
    }
    return DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
  }

  static String ymd(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

  static List<DeliverySlot> slots() =>
      [DeliverySlot.morning, DeliverySlot.afternoon, DeliverySlot.evening];
}
