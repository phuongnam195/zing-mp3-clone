import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/screens/common/playlist_screen.dart';
import 'package:zing_mp3_clone/widgets/explorer/explorer_playlist_card.dart';

import '../../providers/playlist_provider.dart';
import '../../models/playlist.dart';

class AllPlaylistsScreen extends StatelessWidget {
  static const routeName = '/home/all-playlists';

  const AllPlaylistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Danh sách tất cả playlist
    final List<Playlist> playlists = PlaylistProvider.instance.list;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Playlist"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.keyboard_backspace_outlined)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.92,
                  ),
                  itemCount: playlists.length,
                  itemBuilder: (ctx, index) {
                    final playlist = playlists[index];
                    return Center(
                      child: ExplorerPlaylistCard(
                        title: playlist.title,
                        thumbnailUrl: playlist.imageUrl!,
                        onTap: () {
                          Navigator.of(context).pushNamed(PlaylistScreen.routeName, arguments: {
                            'type': 'ExplorerPlaylist',
                            'id': playlist.id,
                          });
                        },
                      ),
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
