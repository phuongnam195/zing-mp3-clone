import 'package:zing_mp3_clone/models/playlist.dart';

class Account {
  final String uid;
  final String name;
  final String email;
  List<String> favorites;
  List<Playlist> userPlaylists;

  Account({
    required this.uid,
    required this.name,
    required this.email,
    required this.favorites,
    required this.userPlaylists,
  });
}
