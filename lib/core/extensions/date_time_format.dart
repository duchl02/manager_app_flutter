import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final String formatted = formatter.format(date!);
  return formatted;
}
String formatDateAndTime(DateTime? date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:MM');
  final String formatted = formatter.format(date!);
  return formatted;
}
