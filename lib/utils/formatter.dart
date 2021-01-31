
import 'package:intl/intl.dart';

class Formatter {

  static final dateFormat = 'MM/dd/yyyy';

  static String dateToString(DateTime dateTime){
    return DateFormat(dateFormat).format(dateTime);
  }

  static DateTime stringToDate(String date){
    return DateFormat(dateFormat).parse(date);
  }

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}