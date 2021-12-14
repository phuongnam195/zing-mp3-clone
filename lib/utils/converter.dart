class Converter {
  static String formatSecond(int sec) {
    int s = sec % 60;
    sec = sec ~/ 60;
    int m = sec % 60;
    int h = sec ~/ 60;
    String ss = s.toString().padLeft(2, '0');
    String sm = m.toString().padLeft(2, '0');

    if (h > 0) {
      return '$h:$sm:$ss';
    }
    return '$m:$ss';
  }
}
