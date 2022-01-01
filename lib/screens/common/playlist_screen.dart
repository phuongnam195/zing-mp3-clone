import 'dart:ui';

import 'package:flutter/material.dart';

import '../../widgets/common/music_card.dart';
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

    late final Playlist playlist;
    late final String title;
    late final int numberOfMusic;

    final arguments =
        ModalRoute.of(context)!.settings.arguments! as Map<String, String>;
    final type = arguments['type'];
    if (type == 'ExplorerPlaylist') {
      final playlistId = arguments['id']!;
      playlist = PlaylistProvider.instance.getByID(playlistId);
      title = playlist.title;
      numberOfMusic = playlist.musicIDs.length;
    }

    return Stack(
      children: [
        type == 'ExplorerPlaylist'
            ? Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(playlist.imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.black.withOpacity(0.02),
                    )),
              )
            : Image.asset('assets/images/playlist/user_playlist_background.jpg',
                fit: BoxFit.fitWidth),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.keyboard_backspace_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                title + ' (' + numberOfMusic.toString() + ')',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: const StadiumBorder(),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                        ),
                        onPressed: () {
                          playerController.maximizeScreen(context);
                          playerController.setShufflePlaylist(playlist);
                        },
                        child: const Text('PHÁT NGẪU NHIÊN',
                            style: TextStyle(fontSize: 15))),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: FutureBuilder<List<Music>>(
                      future: playlist.getMusicList(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final musicList = snapshot.data!;
                        return ListView.builder(
                          itemCount: numberOfMusic,
                          itemBuilder: (ctx, index) {
                            final music = musicList[index];
                            return MusicCard(
                              title: music.title,
                              artists: music.artists,
                              thumbnailUrl: music.thumbnailUrl,
                              onTap: () {
                                if (!playerController.isActive) {
                                  playerController.maximizeScreen(context);
                                }
                                playerController.setMusic(music);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
