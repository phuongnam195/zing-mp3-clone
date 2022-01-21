import 'package:flutter/material.dart';

import '../utils/config.dart';
import '../screens/common/playlist_screen.dart';
import '../widgets/personal/personal_playlist_card.dart';
import '../widgets/personal/library_playlist_card.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const HORIZ_PADDING = 20.0;
    const GAP = 8.0;

    final userPlaylists = Config.instance.myAccount?.userPlaylists;

    // lpc = LibraryPlaylistCard
    final lpcWidth = (screenWidth - 2 * HORIZ_PADDING - GAP) / 2;

    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: HORIZ_PADDING,
          right: HORIZ_PADDING),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Text('Thư viện',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            const SizedBox(height: GAP),
            Row(
              children: [
                LibraryPlaylistCard(
                  title: 'Tất cả bài hát',
                  iconAsset: 'assets/icons/music_library_48.png',
                  width: lpcWidth,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(PlaylistScreen.routeName, arguments: {
                      'type': 'AllMusics',
                    });
                  },
                ),
                const SizedBox(width: GAP),
                LibraryPlaylistCard(
                  title: 'Trên thiết bị',
                  iconAsset: 'assets/icons/ipod_old_48.png',
                  width: lpcWidth,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(PlaylistScreen.routeName, arguments: {
                      'type': 'DeviceMusics',
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: GAP),
            LibraryPlaylistCard(
              title: 'Đã tải',
              iconAsset: 'assets/icons/download_48.png',
              width: lpcWidth,
            ),
            if (userPlaylists != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const Text('Playlist của tôi',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  const SizedBox(height: GAP),
                  for (var playlist in userPlaylists)
                    PersonalPlaylistCard(playlist),
                ],
              )
          ],
        ),
      ),
    );
  }
}
