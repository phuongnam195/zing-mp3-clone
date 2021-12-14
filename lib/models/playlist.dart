import 'dart:convert';

import 'package:zing_mp3_clone/providers/music_provider.dart';
import 'package:zing_mp3_clone/models/music.dart';

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
    List<String> musics = [];
    for (var music in map['musicIDs']) {
      musics.add(music as String);
    }
    return Playlist(
      id: id,
      title: map['title'],
      imageUrl: map['imageUrl'],
      musicIDs: musics,
    );
  }

  Map get toMap => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
        'musicIDs': jsonEncode(musicIDs),
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
