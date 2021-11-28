import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zing_mp3_clone/models/playlist.dart';

class AllPlaylists {
  static final AllPlaylists instance = AllPlaylists._internal();
  AllPlaylists._internal();

  List<Playlist> _list = [];

  List<Playlist> get list => [..._list];

  Future<void> fetchAndSetData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore.collection('playlists').get();
      final queryDocumentSnapshots = querySnapshot.docs;

      _list.clear();
      for (var qds in queryDocumentSnapshots) {
        final playlist = Playlist.fromMap(qds.data(), qds.id);
        _list.add(playlist);
      }
    } catch (error) {
      print('<<Exception-AllPlaylists-fetchAndSetData>> ' + error.toString());
    }
  }
}
