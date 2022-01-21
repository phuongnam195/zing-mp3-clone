// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../models/music.dart';

class DeviceMusicProvider {
  static final DeviceMusicProvider instance = DeviceMusicProvider._internal();
  DeviceMusicProvider._internal();

  List<Music> _list = [];
  List<Music> get list => [..._list];

  // final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  // Future<void> scanAudioFiles() async {
  //   List<SongInfo> songs = await audioQuery.getSongs();
  //   _list = songs
  //       .map((e) => Music.device(
  //           id: e.id,
  //           title: e.title,
  //           audioUrl: e.filePath,
  //           artists: e.artist,
  //           duration: int.parse(e.duration) ~/ 1000))
  //       .toList();
  // }
}
