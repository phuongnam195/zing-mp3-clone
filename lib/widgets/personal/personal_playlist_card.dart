import 'package:flutter/material.dart';

import '../../config.dart';
import '../../models/playlist.dart';

class PersonalPlaylistCard extends StatelessWidget {
  const PersonalPlaylistCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Config.instance.myAccount == null ||
        Config.instance.myAccount!.userPlaylists.isEmpty) {
      return const Text('Không có dữ liệu');
    }

    // Dữ liệu giả
    final Playlist userPlaylist = Config.instance.myAccount!.userPlaylists[0];
    final String title = userPlaylist.title;
    final int numberOfMusics = userPlaylist.musicIDs.length;
    final String imageUrl = userPlaylist.getMusicAtIndex(0).imageUrl;

    return ListTile();
  }
}
