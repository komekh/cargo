import 'package:intl/intl.dart';

class DateUtil {
  static String formatDateTimeToDDMMYYYY(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }
}
