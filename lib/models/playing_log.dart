import 'package:cloud_firestore/cloud_firestore.dart';

class PlayingLog {
  final String id;
  final String musicID;
  final String listenerUID;
  final Timestamp datetime;

  PlayingLog({
    required this.id,
    required this.musicID,
    required this.listenerUID,
    required this.datetime,
  });

  factory PlayingLog.fromMap(Map<String, dynamic> map, String id) {
    return PlayingLog(
      id: id,
      musicID: map['musicID'],
      listenerUID: map['listenerUID'],
      datetime: map['datetime'],
    );
  }
}
