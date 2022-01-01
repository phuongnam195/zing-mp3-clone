import 'package:flutter/material.dart';

import '../../providers/playlist_provider.dart';
import '../../models/playlist.dart';

class AllPlaylistsScreen extends StatelessWidget {
  const AllPlaylistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Danh sách tất cả playlist
    final List<Playlist> playlists = PlaylistProvider.instance.list;

    // TODO: Tham khảo trong page Explorer để tạo GridView gồm 2 cột và n hàng,
    // chứa tất cả playlist

    return Scaffold();
  }
}
