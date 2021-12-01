class Music {
  final String id;
  final String title;
  final String artists;
  final String imageUrl;
  final String thumbnailUrl;
  final String audioUrl;
  final int duration;
  final String lyrics;

  Music({
    required this.id,
    required this.title,
    required this.artists,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.audioUrl,
    required this.duration,
    required this.lyrics,
  });

  factory Music.fromMap(Map<String, dynamic> map, String id) {
    return Music(
      id: id,
      title: map['title'],
      artists: map['artists'],
      imageUrl: map['imageUrl'],
      thumbnailUrl: map['thumbnailUrl'],
      audioUrl: map['audioUrl'],
      duration: map['duration'],
      lyrics: map['lyrics'].replaceAll('\\n', '\n'),
    );
  }
}
