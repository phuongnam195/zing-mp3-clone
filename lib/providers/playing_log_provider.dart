import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/config.dart';
import '../models/playing_log.dart';

class PlayingLogProvider {
  static final PlayingLogProvider instance = PlayingLogProvider._internal();
  PlayingLogProvider._internal();

  final collection = FirebaseFirestore.instance.collection('playing_logs');

  final List<PlayingLog> _list = [];
  List<PlayingLog> get list => [..._list];

  final StreamController<List<PlayingLog>> _newLogController =
      StreamController<List<PlayingLog>>.broadcast();
  Stream<List<PlayingLog>> get onNewLogs => _newLogController.stream;

  Future<void> fetchAndSetData() async {
    try {
      final querySnapshot = await collection.orderBy('datetime').get();
      final queryDocumentSnapshots = querySnapshot.docs;

      _list.clear();
      for (var qds in queryDocumentSnapshots) {
        final log = PlayingLog.fromMap(qds.data(), qds.id);
        _list.add(log);
      }
    } catch (error) {
      print('<<Exception-AllPlayingLogs-fetchAndSetData>> ' + error.toString());
    }
  }

  bool _isSetup = false;
  void setupChangesListener() {
    if (_isSetup) return;
    final firestore = FirebaseFirestore.instance;
    firestore
        .collection('playing_logs')
        .orderBy('datetime')
        .snapshots()
        .listen((querySnapshot) {
      List<PlayingLog> newLogs = [];
      for (var docChange in querySnapshot.docChanges) {
        final newLog =
            PlayingLog.fromMap(docChange.doc.data()!, docChange.doc.id);
        newLogs.add(newLog);
        _list.add(newLog);
      }
      if (querySnapshot.docChanges.isNotEmpty) {
        _newLogController.add(newLogs);
      }
    });
    _isSetup = true;
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
