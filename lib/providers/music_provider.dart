import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/music.dart';

class MusicProvider {
  static final MusicProvider instance = MusicProvider._internal();
  MusicProvider._internal();

  final List<Music> _list = [];

  List<Music> get list => [..._list];
  Music getByID(String id) => _list.firstWhere((music) => music.id == id);

  Future<void> fetchAndSetData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore.collection('musics').get();
      final queryDocumentSnapshots = querySnapshot.docs;

      _list.clear();
      for (var qds in queryDocumentSnapshots) {
        try {
          final music = Music.fromMap(qds.data(), qds.id);
          _list.add(music);
        } catch (error) {
          print('<<Exception-AllMusics-fetchAndSetData-${qds.id}>>' +
              error.toString());
        }
      }
    } catch (error) {
      print('<<Exception-AllMusics-fetchAndSetData>> ' + error.toString());
    }
  }

  List<Music> search(String keyword) {
    List<Music> result = [];
    keyword.replaceAll(' ', '');
    for (var music in list) {
      var encodeString = music.title + music.artists + music.title;
      encodeString.replaceAll(' ', '');

      if (encodeString.contains(RegExp(keyword, caseSensitive: false))) {
        result.add(music);
      }
    }
    return result;
  }

  List<Music> getSorted() {
    // TODO: Sắp xếp giảm dần dùng playing_log
    return list;
  }
}
