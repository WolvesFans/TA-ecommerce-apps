import 'package:intl/intl.dart';

//constants format penuliasn
class CFormatter {
  //format tanggal
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  //format kurs
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'ID', symbol: 'Rp').format(amount);
  }

  //format no. tlp
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isNotEmpty) {
      return '${phoneNumber.substring(0, 4)}-${phoneNumber.substring(4, 8)}-${phoneNumber.substring(8, 12)}${phoneNumber.substring(12)}';
    } else {
      return phoneNumber;
    }
  }
}
