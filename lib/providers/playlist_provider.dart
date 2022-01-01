import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/playlist.dart';

class PlaylistProvider {
  static final PlaylistProvider instance = PlaylistProvider._internal();
  PlaylistProvider._internal();

  final List<Playlist> _list = [];

  List<Playlist> get list => [..._list];
  Playlist getByID(String id) =>
      _list.firstWhere((playlist) => playlist.id == id);

  Future<void> fetchAndSetData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore.collection('playlists').get();
      final queryDocumentSnapshots = querySnapshot.docs;

      _list.clear();
      for (var qds in queryDocumentSnapshots) {
        final playlist = Playlist.fromMapFirebase(qds.data(), qds.id);
        _list.add(playlist);
      }
    } catch (error) {
      print('<<Exception-AllPlaylists-fetchAndSetData>> ' + error.toString());
    }
  }
}
