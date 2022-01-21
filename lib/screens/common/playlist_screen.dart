import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/providers/device_music_provider.dart';

import '../../providers/music_provider.dart';
import '../../models/playlist.dart';
import '../../widgets/common/music_card.dart';
import '../../controllers/player_controller.dart';
import '../../providers/playlist_provider.dart';
import '../../models/music.dart';

class PlaylistScreen extends StatefulWidget {
  static const routeName = '/home/playlist';

  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final playerController = PlayerController.instance;

  late List<Music> musics;
  late final String title;
  late final int numberOfMusic;
  String? backgroundUrl;
  String? backgroundAsset;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (isLoading) {
      return;
    }

    void getMusicsFromPlaylist(Playlist playlist) async {
      setState(() {
        isLoading = true;
      });
      musics = await playlist.getMusicList();
      setState(() {
        isLoading = false;
      });
    }

    final arguments =
        ModalRoute.of(context)!.settings.arguments! as Map<String, String>;
    final type = arguments['type']!;

    switch (type) {
      case 'ExplorerPlaylist':
        final playlistId = arguments['id']!;
        final playlist = PlaylistProvider.instance.getByID(playlistId);
        getMusicsFromPlaylist(playlist);
        title = playlist.title;
        numberOfMusic = playlist.musicIDs.length;
        backgroundUrl = playlist.imageUrl;
        break;

      case 'AllMusics':
        musics = MusicProvider.instance.list;
        title = 'Tất cả bài hát';
        numberOfMusic = musics.length;
        backgroundAsset = 'assets/images/playlist/user_playlist_background.jpg';
        break;

      case 'DeviceMusics':
        musics = DeviceMusicProvider.instance.list;
        title = 'Trên thiết bị';
        numberOfMusic = musics.length;
        backgroundAsset = 'assets/images/playlist/user_playlist_background.jpg';
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundUrl != null
            ? Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(backgroundUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.black.withOpacity(0.02),
                    )),
              )
            : Image.asset(backgroundAsset!, fit: BoxFit.fitWidth),
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
                          playerController.setMusicList(musics, shuffle: true);
                        },
                        child: const Text('PHÁT NGẪU NHIÊN',
                            style: TextStyle(fontSize: 15))),
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Colors.white,
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: numberOfMusic,
                              itemBuilder: (ctx, index) {
                                final music = musics[index];
                                return MusicCard(
                                  title: music.title,
                                  artists: music.artists,
                                  thumbnailUrl: music.thumbnailUrl,
                                  onTap: () {
                                    if (!playerController.isActive) {
                                      playerController.maximizeScreen(context);
                                    }
                                    playerController.setMusicList(musics,
                                        index: index);
                                  },
                                );
                              },
                            )),
                ),
              ],
            ))
      ],
    );
  }
}
