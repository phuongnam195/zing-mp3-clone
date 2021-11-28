class Playlist {
  final String id;
  final String title;
  String? imageUrl;
  final List<String> musicIDs;

  Playlist({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.musicIDs,
  });

  factory Playlist.fromMap(Map<String, dynamic> map, String id) {
    List<String> musics = [];
    for (var music in map['musicIDs']) {
      musics.add(music as String);
    }
    return Playlist(
      id: id,
      title: map['title'],
      imageUrl: map['imageUrl'],
      musicIDs: musics,
    );
  }
}
