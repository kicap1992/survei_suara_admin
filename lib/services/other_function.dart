import 'package:intl/intl.dart';

class MyFunction {
  String convertDateTime(String input) {
    DateTime dateTime = DateTime.parse(input);
    String formattedDateTime =
        DateFormat('dd-MM-yyyy | hh.mm.ss a').format(dateTime);
    return formattedDateTime;
  }

  // chnage | to \n in string
  String convertDateTime2(String input) {
    input = input.replaceAll('| ', '\n');
    return input;
  }
}
