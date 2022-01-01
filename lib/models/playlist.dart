import '../providers/music_provider.dart';
import 'music.dart';

class Playlist {
  final String id;
  String title;
  String? imageUrl;
  final List<String> musicIDs;

  Playlist({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.musicIDs,
  });

  factory Playlist.fromMap(Map<String, dynamic> map, String id) {
    return Playlist(
      id: id,
      title: map['title'],
      imageUrl: map['imageUrl'],
      musicIDs: (map['musicIDs'] as String).split('&&&&'),
    );
  }

  factory Playlist.fromMapFirebase(Map<String, dynamic> map, String id) {
    return Playlist(
      id: id,
      title: map['title'],
      imageUrl: map['imageUrl'],
      musicIDs:
          (map['musicIDs'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map toMap() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
        'musicIDs': musicIDs.join('&&&&'),
      }..removeWhere((_, value) => value == null);

  Future<List<Music>> getMusicList() async {
    List<Music> result = [];
    for (var musicId in musicIDs) {
      result.add(MusicProvider.instance.getByID(musicId));
    }
    return result;
  }

  Music getMusicAtIndex(int index) {
    final musicId = musicIDs[index];
    return MusicProvider.instance.getByID(musicId);
  }
}
