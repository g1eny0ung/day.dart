import 'day.dart';
import 'constants.dart' as C;

const _unitMap = {
  'y': C.Y,
  'M': C.M,
  'd': C.D,
  'w': C.W,
  'h': C.H,
  'm': C.MIN,
  's': C.S,
  'ms': C.MS
};

String processUnit(String unit) {
  if (_unitMap.containsKey(unit)) {
    return _unitMap[unit];
  }

  return unit.trim().toLowerCase();
}

Duration durationFromUnit(int val, String unit) {
  switch (unit) {
    case C.D:
      return Duration(days: val);
    case C.H:
      return Duration(hours: val);
    case C.MIN:
      return Duration(minutes: val);
    case C.S:
      return Duration(seconds: val);
    case C.MS:
      return Duration(milliseconds: val);
    default:
      return null;
  }
}

int processDiffDuration(Duration duration, String unit) {
  switch (unit) {
    case C.D:
      return duration.inDays.abs();
    case C.H:
      return duration.inHours.abs();
    case C.MIN:
      return duration.inMinutes.abs();
    case C.S:
      return duration.inSeconds.abs();
    case C.MS:
      return duration.inMilliseconds.abs();
    default:
      return null;
  }
}

String processMatchFromFormat(Match m, Day day) {
  final locale = day.localLocale != null ? day.localLocale : Day.locale;

  switch (m[0]) {
    case 'Y':
    case 'YY':
      final year = day.year().toString();

      return year.substring(year.length - 2, year.length);
    case 'YYY':
    case 'YYYY':
      return day.year().toString();
    case 'M':
      return day.month().toString();
    case 'MM':
      return day.month().toString().padLeft(2, '0');
    case 'MMM':
      return locale['Name'] == 'en'
          ? locale['Months'][day.month()].substring(0, 3)
          : locale['MonthsShort'][day.month()];
    case 'MMMM':
      return locale['Months'][day.month()];
    case 'D':
      return day.date().toString();
    case 'DD':
      return day.date().toString().padLeft(2, '0');
    case 'W':
      return day.weekday().toString();
    case 'WW':
      return locale['Name'] == 'en'
          ? locale['Weekdays'][day.weekday()].substring(0, 2)
          : locale['WeekdaysMin'][day.weekday()];
    case 'WWW':
      return locale['Name'] == 'en'
          ? locale['Weekdays'][day.weekday()].substring(0, 3)
          : locale['WeekdaysShort'][day.weekday()];
    case 'WWWW':
      return locale['Weekdays'][day.weekday()];
    case 'H':
      return day.hour().toString();
    case 'HH':
      return day.hour().toString().padLeft(2, '0');
    case 'h':
      return _getHourAs12(day.hour()).toString();
    case 'hh':
      return _getHourAs12(day.hour()).toString().padLeft(2, '0');
    case 'm':
      return day.minute().toString();
    case 'mm':
      return day.minute().toString().padLeft(2, '0');
    case 's':
      return day.second().toString();
    case 'ss':
      return day.second().toString().padLeft(2, '0');
    case 'SSS':
      return day.millisecond().toString().padLeft(3, '0');
    case 'A':
      return _toAMOrPM(day.hour(), locale);
    case 'a':
      return _toAMOrPM(day.hour(), locale, true);
    default:
      return null;
  }
}

int _getHourAs12(int hour) {
  return hour <= 12 ? hour : hour - 12;
}

String _toAMOrPM(int hour, dynamic locale, [bool toLowercase = false]) {
  final result = hour < 12 ? locale['AM'] : locale['PM'];

  return toLowercase ? result.toLowerCase() : result;
}