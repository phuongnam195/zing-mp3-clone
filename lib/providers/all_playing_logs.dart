import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/playing_log.dart';

class AllPlayingLogs extends ChangeNotifier {
  List<PlayingLog> _list = [];

  List<PlayingLog> get list => [..._list];

  Future<void> fetchAndSetData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot =
          await firestore.collection('playing_logs').orderBy('datetime').get();
      final queryDocumentSnapshots = querySnapshot.docs;

      _list.clear();
      for (var qds in queryDocumentSnapshots) {
        final music = PlayingLog.fromMap(qds.data(), qds.id);
        _list.add(music);
      }
    } catch (error) {
      print('<<Exception-AllPlayingLogs-fetchAndSetData>> ' + error.toString());
    }
  }

  void setupChangesListener() {
    final firestore = FirebaseFirestore.instance;
    firestore
        .collection('playing_logs')
        .orderBy('datetime')
        .snapshots()
        .listen((querySnapshot) {
      for (var docChange in querySnapshot.docChanges) {
        final newLog =
            PlayingLog.fromMap(docChange.doc.data()!, docChange.doc.id);
        _list.add(newLog);
      }
      notifyListeners();
    });
  }
}
