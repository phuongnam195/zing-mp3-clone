import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zing_mp3_clone/models/music.dart';

class AllMusics {
  static final AllMusics instance = AllMusics._internal();
  AllMusics._internal();

  List<Music> _list = [];

  List<Music> get list => [..._list];

  Future<void> fetchAndSetData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore.collection('musics').get();
      final queryDocumentSnapshots = querySnapshot.docs;

      _list.clear();
      for (var qds in queryDocumentSnapshots) {
        final music = Music.fromMap(qds.data(), qds.id);
        _list.add(music);
      }
    } catch (error) {
      print('<<Exception-AllMusics-fetchAndSetData>> ' + error.toString());
    }
  }
}
