class Music {
  final String id;
  final String title;
  final String artists;
  final String imageUrl;
  final String thumbnailUrl;
  final String audioUrl;
  final int duration;
  String? lyrics;

  Music({
    required this.id,
    required this.title,
    required this.artists,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.audioUrl,
    required this.duration,
    this.lyrics,
  });

  factory Music.fromMap(Map<String, dynamic> map, String id) {
    if (id == '0JFGwaKDUU5zN6co8zoH') {
      var x = 3;
    }
    String? lyrics = map['lyrics'];
    if (lyrics != null) {
      lyrics = lyrics.replaceAll('\\n', '\n');
    }

    return Music(
      id: id,
      title: map['title'],
      artists: map['artists'],
      imageUrl: map['imageUrl'],
      thumbnailUrl: map['thumbnailUrl'],
      audioUrl: map['audioUrl'],
      duration: map['duration'],
      lyrics: lyrics,
    );
  }

  Map<String, Object> toMap() {
    var map = {
      'title': title,
      'artists': artists,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
      'audioUrl': audioUrl,
      'duration': duration,
    };
    if (lyrics != null) {
      map['lyrics'] = lyrics!;
    }
    return map;
  }
}
