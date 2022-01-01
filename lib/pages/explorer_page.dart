import 'package:flutter/material.dart';

import '../providers/playlist_provider.dart';
import '../screens/common/playlist_screen.dart';
import '../widgets/explorer/explorer_playlist_card.dart';
import '../widgets/explorer/music_rank.dart';

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allPlaylists = PlaylistProvider.instance.list;

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text('Playlist',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Xem thêm',
                    ),
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.92,
                ),
                itemCount: allPlaylists.length,
                itemBuilder: (ctx, index) {
                  final playlist = allPlaylists[index];
                  return Center(
                    child: ExplorerPlaylistCard(
                      title: playlist.title,
                      thumbnailUrl: playlist.imageUrl!,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(PlaylistScreen.routeName, arguments: {
                          'type': 'ExplorerPlaylist',
                          'id': playlist.id
                        });
                      },
                    ),
                  );
                },
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Text('Bảng xếp hạng',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
            const MusicRank(),
          ],
        ),
      ),
    );
  }
}
