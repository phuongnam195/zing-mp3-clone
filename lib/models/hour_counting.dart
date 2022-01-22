const int HOURS = 4;

class Point {
  int x, y;
  Point(this.x, this.y);
}

class HourCounting {
  final String musicID;
  final Map<DateTime, int> _listens = {};
  int color = 0; // 1, 2, 3

  HourCounting(this.musicID, DateTime firstHour) {
    for (int i = 0; i < HOURS; i++) {
      DateTime hour = firstHour.add(Duration(hours: i));
      _listens[hour] = 0;
    }
  }

  int sumListens(DateTime currentHour) {
    int s = 0;
    for (int i = HOURS - 1; i >= 0; i--) {
      DateTime hour = currentHour.subtract(Duration(hours: i));
      s += _listens[hour] ?? 0;
    }
    return s;
  }

  List<Point> getPoints(DateTime currentHour) {
    List<Point> result = [];
    for (int i = HOURS - 1; i >= 0; i--) {
      DateTime hour = currentHour.subtract(Duration(hours: i));
      if (!_listens.containsKey(hour)) {
        _listens[hour] = 0;
      }
      result.add(Point(hour.hour, _listens[hour]!));
    }
    return result;
  }

  void inc(DateTime hour) {
    _listens.update(hour, (value) => value + 1, ifAbsent: () => 0);
  }

  bool equals(HourCounting other) =>
      musicID == other.musicID &&
      _listens == other._listens &&
      color == other.color;
}
