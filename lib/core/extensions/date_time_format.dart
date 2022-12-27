import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(date!);
  return formatted;
}
