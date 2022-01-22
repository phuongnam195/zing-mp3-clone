import 'music_provider.dart';
import 'playing_log_provider.dart';

class RankedMusic {
  RankedMusic(
    this.musicId,
    this.listens,
  );

  final String musicId;
  int listens;
}

class RankedMusicProvider {
  static final RankedMusicProvider instance = RankedMusicProvider._internal();
  RankedMusicProvider._internal();

  List<RankedMusic> dayRanks = [];
  List<RankedMusic> weekRanks = [];
  List<RankedMusic> totalRanks = [];

  Future<void> countAndSort() async {
    final logs = PlayingLogProvider.instance.list;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    Map<String, int> countDay = {};
    Map<String, int> countWeek = {};
    Map<String, int> countTotal = {};

    for (var music in MusicProvider.instance.list) {
      countDay[music.id] = 0;
      countWeek[music.id] = 0;
      countTotal[music.id] = 0;
    }

    for (var log in logs) {
      final datetime = log.datetime.toDate();
      final date = DateTime(datetime.year, datetime.month, datetime.day);

      if (date == today) {
        countDay.update(log.musicID, (value) => value + 1);
      }
      if (today.difference(date).inDays <= 7) {
        countWeek.update(log.musicID, (value) => value + 1);
      }
      countTotal.update(log.musicID, (value) => value + 1);
    }

    dayRanks.clear();
    weekRanks.clear();
    totalRanks.clear();

    countDay.forEach((key, value) {
      dayRanks.add(RankedMusic(key, value));
    });
    countWeek.forEach((key, value) {
      weekRanks.add(RankedMusic(key, value));
    });
    countTotal.forEach((key, value) {
      totalRanks.add(RankedMusic(key, value));
    });

    dayRanks.sort((a, b) => (b.listens - a.listens));
    weekRanks.sort((a, b) => (b.listens - a.listens));
    totalRanks.sort((a, b) => (b.listens - a.listens));
  }
}
