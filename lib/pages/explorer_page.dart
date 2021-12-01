import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/controller/player_controller.dart';
import 'package:zing_mp3_clone/data/all_playlists.dart';
import 'package:zing_mp3_clone/screens/common/playlist_screen.dart';
import 'package:zing_mp3_clone/widgets/explorer/explorer_playlist_card.dart';

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allPlaylists = AllPlaylists.instance.list;

    return GridView.builder(
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
              Navigator.of(context).pushNamed(PlaylistScreen.routeName);
            },
          ),
        );
      },
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
