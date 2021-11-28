class Music {
  final String id;
  final String title;
  final String artists;
  final String imageUrl;
  final String audioUrl;
  final int duration;

  Music({
    required this.id,
    required this.title,
    required this.artists,
    required this.imageUrl,
    required this.audioUrl,
    required this.duration,
  });

  factory Music.fromMap(Map<String, dynamic> map, String id) {
    return Music(
      id: id,
      title: map['title'],
      artists: map['artists'],
      imageUrl: map['imageUrl'],
      audioUrl: map['audioUrl'],
      duration: map['duration'],
    );
  }
}
