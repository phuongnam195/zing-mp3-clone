import 'package:audioplayers/audioplayers.dart';

class Channel {
  final String title;
  final String streamUrl;
  final String imageUrl;
  Channel(
      {required this.title, required this.streamUrl, required this.imageUrl});
}

class RadioProvider {
  static final RadioProvider instance = RadioProvider._internal();
  RadioProvider._internal();

  // Credit: https://github.com/amangautam1/flutter-radio/blob/master/lib/lsit.dart

  int current = -1;

  final AudioPlayer _audioPlayer = AudioPlayer();

  bool get isPlaying => current != -1;

  void play(int index) {
    if (current == index) {
      _audioPlayer.stop();
      current = -1;
    } else {
      current = index;
      _audioPlayer.play(_channels[index].streamUrl);
    }
  }

  void stop() {
    current = -1;
    _audioPlayer.stop();
  }

  List<Channel> get channels => [..._channels];
  final List<Channel> _channels = [
    Channel(
        title: 'Desi Music Mix',
        streamUrl: 'http://158.69.161.125:8012/?type=http&nocache=57533',
        imageUrl:
            'https://mytuner.global.ssl.fastly.net/media/tvos_radios/Typgmp8Z8D.png'),
    Channel(
        title: 'Hindi Music Radio',
        streamUrl: 'http://5.196.56.208:8308/stream',
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51WSc%2BN-5CL._SY355_.png'),
    Channel(
        title: 'Mehfil Radio',
        streamUrl: 'http://mehefil.no-ip.com/mehefil',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSMd4s3oWzzUvWBM_7L54w5_qduRsvThX3vChcnC3eGj1BoZc8Q&usqp=CAU'),
    Channel(
        title: 'Radio Central',
        streamUrl: 'http://176.31.107.8:8459/stream',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4X8tigdkbQtr7R7U2Vesifoo7_e3sGsk_wBV7GqEgBNZfZPA&s')
  ];
}
