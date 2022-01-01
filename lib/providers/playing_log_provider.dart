import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../config.dart';
import '../models/playing_log.dart';

class PlayingLogProvider {
  static final PlayingLogProvider instance = PlayingLogProvider._internal();
  PlayingLogProvider._internal();

  final List<PlayingLog> _list = [];

  List<PlayingLog> get list => [..._list];

  final collection = FirebaseFirestore.instance.collection('playing_logs');

  Future<void> fetchAndSetData() async {
    try {
      final querySnapshot = await collection.orderBy('datetime').get();
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
      if (querySnapshot.docChanges.isNotEmpty) {
        // notifyListeners();
      }
    });
  }

  void addNewLog(String musicId) {
    Map<String, dynamic> map = {
      'musicID': musicId,
      'listenerUID': Config.instance.myAccount?.uid ?? '',
      'datetime': Timestamp.now(),
    };
    collection.add(map);
  }
}
