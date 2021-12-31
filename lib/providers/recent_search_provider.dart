import 'package:shared_preferences/shared_preferences.dart';

import '../models/music.dart';
import 'music_provider.dart';

class RecentSearchProvider {
  static final RecentSearchProvider instance = RecentSearchProvider._internal();
  RecentSearchProvider._internal();

  List<String> _recentSearchMusicIDs = [];

  // Lấy danh sách bài hát tìm kiếm gần đây
  List<Music> get list => _recentSearchMusicIDs
      .map((id) => MusicProvider.instance.getByID(id))
      .toList();

  // Thêm một bài hát vừa tìm kiếm (tối đa 5)
  void add(String musicID) {
    if (_recentSearchMusicIDs.contains(musicID)) {
      _recentSearchMusicIDs.remove(musicID);
    }
    _recentSearchMusicIDs.insert(0, musicID);
    if (_recentSearchMusicIDs.length > 5) {
      _recentSearchMusicIDs.removeLast();
    }
    save();
  }

  // Lưu danh sách tìm kiếm gần đây
  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recent_search_music_ids', _recentSearchMusicIDs);
  }

  // Nạp danh sách tìm kiếm gần đây
  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _recentSearchMusicIDs.clear();
    _recentSearchMusicIDs =
        prefs.getStringList('recent_search_music_ids') ?? [];
  }
}
