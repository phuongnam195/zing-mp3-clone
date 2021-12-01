import 'playlist.dart';

class Account {
  final String uid;
  final String name;
  final String email;
  List<Playlist> userPlaylists;

  Account({
    required this.uid,
    required this.name,
    required this.email,
    required this.userPlaylists,
  });
}
