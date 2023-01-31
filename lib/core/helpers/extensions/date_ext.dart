import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  //   final DateFormat formatter = DateFormat('dd-MM-yyyy');
  // final String formatted = formatter.format(date!);
  String get getStartDate {
    DateFormat transactionDateFormat = DateFormat('dd-MM-yyyy');
    return transactionDateFormat.format(this);
  }

  String get getEndDate {
    DateFormat transactionDateFormat = DateFormat('dd-MM-yyyy');
    return transactionDateFormat.format(this);
  }
}
