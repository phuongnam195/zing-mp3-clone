class MyDateTime {
  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime getDate(DateTime datetime) {
    return DateTime(datetime.year, datetime.month, datetime.day);
  }

  static DateTime getToHour(DateTime datetime) {
    return DateTime(datetime.year, datetime.month, datetime.day, datetime.hour);
  }

  static bool isToday(DateTime datetime) =>
      getDate(datetime).compareTo(MyDateTime.today) == 0;

  static DateTime get yesterday {
    final dtYTD = DateTime.now().subtract(const Duration(days: 1));
    return DateTime(dtYTD.year, dtYTD.month, dtYTD.day);
  }

  static bool isYesterday(DateTime datetime) {
    DateTime ytd = MyDateTime.yesterday;
    return datetime.year == ytd.year &&
        datetime.month == ytd.month &&
        datetime.day == ytd.day;
  }
}
