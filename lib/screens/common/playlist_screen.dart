import 'package:flutter/material.dart';

import '../../controller/player_controller.dart';
import '../../providers/playlist_provider.dart';
import '../../models/music.dart';
import '../../models/playlist.dart';

class PlaylistScreen extends StatelessWidget {
  static const routeName = '/home/playlist';

  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerController = PlayerController.instance;

    // Dữ liệu giả
    final Playlist playlist = PlaylistProvider.instance.list[0];
    final String title = playlist.title;
    final int numberOfMusic = playlist.musicIDs.length;
    final String backgroundImageUrl = playlist.getMusicAtIndex(0).thumbnailUrl;

    return Scaffold(
        body: Column(children: [
      Stack(
        children: [
          // WIDGET => Ảnh nền: làm mờ (tham khảo trong playing_screen.dart: BackdropFilter), chú ý size
          Column(
            children: [
              // WIDGET => Row: Nút back, tiêu đề, số lượng
              // WIDGET => Container bo tròn 2 góc trên, chứa nút PHÁT NGẪU NHIÊN
              ElevatedButton(
                  onPressed: () {
                    if (!playerController.isActive) {
                      playerController.maximizeScreen(context);
                    }
                    playerController.setShufflePlaylist(playlist);
                    playerController.notifyChange();
                  },
                  child: Text('PHÁT NGẪU NHIÊN')),
            ],
          )
        ],
      ),
      FutureBuilder<List<Music>>(
        future: playlist.getMusicList(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Music> musicList = snapshot.data!;

          // Hiện danh sách: Thay Container bằng ListView.builder()
          // Cách dùng ListView.builder(): Tham khảo trong radio_page.dart
          return Container();
        },
      ),
    ]));
  }
}
