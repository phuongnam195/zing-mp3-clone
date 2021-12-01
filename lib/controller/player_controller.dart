import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/music.dart';
import '../models/playlist.dart';
import '../screens/common/playing_screen.dart';

enum RepeatMode { off, one, all }

class PlayerController {
  static final PlayerController instance = PlayerController._internal();
  PlayerController._internal() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerCompletion.listen((event) {
      playNext();
      notifyChange();
    });
  }

  late final AudioPlayer _audioPlayer;
  final _rng = Random();
  final StreamController<void> _changesController =
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
  bool isShuffleMode = false;
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

  bool get isActive => state != PlayerState.STOPPED;

  Stream<void> get onChange => _changesController.stream;

  // Khi chọn một bài hát đơn lẻ (từ kết quả tìm kiếm)
  void setMusic(Music music) {
    _musicList.clear();
    _playedIndexes.clear();

    _musicList.add(music);
    _currentIndex = 0;

    _play(music);
  }

  // Khi chọn một bài hát bất kì của một playlist
  void setPlaylist(Playlist playlist, int index) {
    _musicList.clear();
    _playedIndexes.clear();

    playlist.getMusicList().then((result) => _musicList = result);

    _currentIndex = index;

    final initMusic = playlist.getMusicAtIndex(index);
    _play(initMusic);
  }

  // Khi ấn "PHÁT NGẪU NHIÊN" một playlist
  void setShufflePlaylist(Playlist playlist) {
    _musicList.clear();
    _playedIndexes.clear();

    playlist.getMusicList().then((result) => _musicList = result);

    _currentIndex = _rng.nextInt(playlist.musicIDs.length);

    final initMusic = playlist.getMusicAtIndex(_currentIndex);
    _play(initMusic);
    isShuffleMode = true;
  }

  void _play(Music music) {
    _audioPlayer.play(music.audioUrl);
    state = PlayerState.PLAYING;
  }

  void togglePlay() {
    if (state == PlayerState.PLAYING) {
      _audioPlayer.pause();
      state = PlayerState.PAUSED;
    } else if (state == PlayerState.PAUSED) {
      _audioPlayer.resume();
      state = PlayerState.PLAYING;
    }
    notifyChange();
  }

  void toggleShuffle() {
    isShuffleMode = !isShuffleMode;
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

  void playNext() {
    if (_musicList.length == 1) {
      return;
    }

    _playedIndexes.add(_currentIndex);

    switch (repeatMode) {
      case RepeatMode.off:
        if (_playedIndexes.length == _musicList.length) {
          state = PlayerState.STOPPED;
          notifyChange();
          return;
        } else {
          _currentIndex = isShuffleMode
              ? _getNextRandomIndex()
              : ((_currentIndex + 1) % _musicList.length);
          _play(_musicList[_currentIndex]);
          notifyChange();
        }
        break;
      case RepeatMode.one:
        _play(_musicList[_currentIndex]);
        break;
      case RepeatMode.all:
        _currentIndex = isShuffleMode
            ? _getNextRandomIndex()
            : ((_currentIndex + 1) % _musicList.length);
        _play(_musicList[_currentIndex]);
        notifyChange();
        break;
    }
  }

  void playPrevious() {
    if (_playedIndexes.isEmpty) {
      _audioPlayer.seek(Duration.zero);
      if (state == PlayerState.PAUSED) {
        _audioPlayer.resume();
      }
    } else {
      _currentIndex = _playedIndexes.last;
      _playedIndexes.removeLast();
      _play(_musicList[_currentIndex]);
      notifyChange();
    }
  }

  int _getNextRandomIndex() {
    List<int> pool = [for (var i = 0; i < _musicList.length; i++) i];
    for (int i = _playedIndexes.length - 1;
        i >= max(0, _playedIndexes.length - _musicList.length);
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

  void notifyChange() {
    _changesController.add(null);
  }
}
