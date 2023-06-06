import 'package:intl/intl.dart';

class DateUtilities {
//  String day = DateFormat('dd').format(forecastDayList[index].date!);
//   String month = DateFormat('MMMM').format(forecastDayList[index].date!);

  static Map<int, DateTime> get nextWeek {
    final Map<int, DateTime> map = {};

    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      map[i] = now;
      now = now.add(const Duration(days: 1));
    }
    return map;
  }

  static List<DateTime> get week => nextWeek.values.toList();
  static DateTime get date => DateTime.now();

  String get printWeek => printWeekName(date);
  String get printMinutes => printMinutesName(date);

  static String printDateWithLine(DateTime date, {String pattern = 'MM-dd-yyyy'}) =>
      DateFormat(pattern).format(date);

  static String printWeekName(DateTime date) => printDateWithLine(date, pattern: 'EEE dd');

  static String printMinutesName(DateTime date) => printDateWithLine(date, pattern: 'kk:mma');

  String dateIntToDateTime(int startDate) {
    var startDateSeconds = DateTime.fromMillisecondsSinceEpoch((startDate) * 1000);

    return DateUtilities.printMinutesName(startDateSeconds);
  }
}
