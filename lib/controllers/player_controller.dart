import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../providers/radio_provider.dart';
import '../providers/playing_log_provider.dart';
import '../models/music.dart';
import '../models/playlist.dart';
import '../screens/common/playing_screen.dart';

enum RepeatMode { off, one, all }

class PlayerController {
  static final PlayerController instance = PlayerController._internal();
  PlayerController._internal() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerCompletion.listen((event) {
      playNext(true);
      notifyMusicChange();
    });
  }

  late final AudioPlayer _audioPlayer;
  final _rng = Random();
  final StreamController<void> _musicChangeController =
      StreamController<void>.broadcast();

  // Danh sách bài hát đang phát
  List<Music> _musicList = [];
  // Các index của bài hát đã phát (lịch sử phát)
  final List<int> _playedIndexes = [];
  // Index của bài hát đang phát
  int _currentIndex = -1;

  // Trạng thái hiện tại: Đang phát, tạm dừng, dừng hẳn, đã phát xong
  PlayerState state = PlayerState.STOPPED;
  // Chế độ shuffle
  bool shuffleMode = false;
  // Chế độ repeat
  RepeatMode repeatMode = RepeatMode.off;
  // Hiện lyrics
  bool isShowingLyrics = false;

  Music? get current {
    _audioPlayer.onPlayerCompletion;
    if (_currentIndex == -1) {
      return null;
    }
    return _musicList[_currentIndex];
  }

  bool get isPlaying => state == PlayerState.PLAYING;

  Stream<Duration> get onPositionChanged => _audioPlayer.onAudioPositionChanged;
  bool get isActive => state != PlayerState.STOPPED;
  Stream<void> get onMusicChanged => _musicChangeController.stream;

  void setPosition(int position) {
    _audioPlayer.seek(Duration(seconds: position));
  }

  // Khi chọn một bài hát đơn lẻ (từ kết quả tìm kiếm)
  void setMusic(Music music) {
    _musicList.clear();
    _playedIndexes.clear();

    _musicList.add(music);
    _currentIndex = 0;

    _play(music);
    notifyMusicChange();
  }

  // Khi chọn một bài hát bất kì của một playlist
  void setPlaylist(Playlist playlist, {int? index, bool shuffle = false}) {
    assert((index != null && !shuffle) || (index == null && shuffle));

    _musicList.clear();
    _playedIndexes.clear();

    playlist.getMusicList().then((result) => _musicList = result);

    if (shuffle) {
      _currentIndex = _rng.nextInt(playlist.musicIDs.length);
    } else {
      _currentIndex = index!;
    }

    final initMusic = playlist.getMusicAtIndex(_currentIndex);
    shuffleMode = shuffle;
    _play(initMusic);
    notifyMusicChange();
  }

  // Khi chọn một bài hát bất kì của một playlist
  void setMusicList(List<Music> musicList, {int? index, bool shuffle = false}) {
    assert((index != null && !shuffle) || (index == null && shuffle));

    _musicList = [...musicList];
    _playedIndexes.clear();

    if (shuffle) {
      _currentIndex = _rng.nextInt(musicList.length);
    } else {
      _currentIndex = index!;
    }

    final initMusic = musicList[_currentIndex];
    shuffleMode = shuffle;
    _play(initMusic);
    notifyMusicChange();
  }

  void _play(Music music) {
    _audioPlayer.play(music.audioUrl);
    state = PlayerState.PLAYING;
    if (!music.isDevice) {
      PlayingLogProvider.instance.addNewLog(music.id);
    }

    if (RadioProvider.instance.isPlaying) {
      RadioProvider.instance.stop();
    }
  }

  void togglePlay() {
    if (state == PlayerState.PLAYING) {
      _audioPlayer.pause();
      state = PlayerState.PAUSED;
    } else if (state == PlayerState.PAUSED) {
      if (RadioProvider.instance.isPlaying) {
        RadioProvider.instance.stop();
      }
      _audioPlayer.resume();
      state = PlayerState.PLAYING;
    }
    notifyMusicChange();
  }

  void toggleShuffle() {
    shuffleMode = !shuffleMode;
  }

  void toggleRepeat() {
    if (repeatMode == RepeatMode.off) {
      repeatMode = RepeatMode.all;
    } else if (repeatMode == RepeatMode.all) {
      repeatMode = RepeatMode.one;
    } else {
      repeatMode = RepeatMode.off;
    }
  }

  // passive = true: playNext được thực hiện khi bài hát kết thúc (bị động)
  // passive = false: playNext được thực hiện khi người dùng ấn nút NEXT (chủ động)
  void playNext([bool passive = false]) {
    _playedIndexes.add(_currentIndex);

    switch (repeatMode) {
      // Nếu không bật REPEAT
      case RepeatMode.off:
        // và nếu bài nào cũng đã được phát, trong điều kiện bài hát tự hết
        if (_playedIndexes.toSet().length == _musicList.length && passive) {
          // thì dừng phát
          state = PlayerState.STOPPED;
        }
        // ngược lại thì phát bài tiếp theo: random hoặc next
        else {
          _currentIndex = shuffleMode
              ? _getNextRandomIndex()
              : ((_currentIndex + 1) % _musicList.length);
          _play(_musicList[_currentIndex]);
        }
        notifyMusicChange();
        break;

      // Nếu bật REPEAT 1 bài
      case RepeatMode.one:
        // và bài hát tự hết
        if (passive) {
          // thì phát lại bài đó
          _play(_musicList[_currentIndex]);
        }
        // do người dùng click
        else {
          // thì phát bài tiếp theo: random hoặc next
          _currentIndex = shuffleMode
              ? _getNextRandomIndex()
              : ((_currentIndex + 1) % _musicList.length);
          _play(_musicList[_currentIndex]);
          notifyMusicChange();
        }
        break;

      // Nếu bật REPEAT cả danh sách
      case RepeatMode.all:
        // thì phát bài tiếp theo: random hoặc next
        _currentIndex = shuffleMode
            ? _getNextRandomIndex()
            : ((_currentIndex + 1) % _musicList.length);
        _play(_musicList[_currentIndex]);
        notifyMusicChange();
        break;
    }
  }

  void playPrevious() {
    if (_playedIndexes.isEmpty) {
      _audioPlayer.seek(Duration.zero);
      if (state == PlayerState.PAUSED) {
        _audioPlayer.resume();
        state = PlayerState.PLAYING;
        notifyMusicChange();
      }
    } else {
      _currentIndex = _playedIndexes.last;
      _playedIndexes.removeLast();
      _play(_musicList[_currentIndex]);
      notifyMusicChange();
    }
  }

  int _getNextRandomIndex() {
    List<int> pool = [for (var i = 0; i < _musicList.length; i++) i];
    for (int i = _playedIndexes.length - 1;
        i >= max(0, _playedIndexes.length - _musicList.length + 1);
        i--) {
      pool.remove(_playedIndexes[i]);
    }
    return pool[_rng.nextInt(pool.length)];
  }

  void maximizeScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PlayingScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }

  void notifyMusicChange() {
    _musicChangeController.add(null);
  }
}
