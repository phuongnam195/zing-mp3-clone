import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../widgets/playing/seekbar.dart';
import '../../controllers/player_controller.dart';

class PlayingScreen extends StatefulWidget {
  static const routeName = '/playing';

  const PlayingScreen({Key? key}) : super(key: key);

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  late bool isPlaying;
  late bool isShuffle;

  @override
  Widget build(BuildContext context) {
    final controller = PlayerController.instance;

    final screenWidth = MediaQuery.of(context).size.width;
    final activeColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: StreamBuilder<void>(
          stream: controller.onMusicChanged,
          builder: (context, snapshot) {
            final playingMusic = controller.current!;

            return Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  image: DecorationImage(
                    image: NetworkImage(playingMusic.thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.black26),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.expand_more,
                              color: Colors.white,
                              size: 26,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              playingMusic.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              playingMusic.artists,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        PopupMenuButton(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 26,
                          ),
                          itemBuilder: (ctx) => [
                            PopupMenuItem(
                              child: Text(controller.isShowingLyrics
                                  ? 'Ẩn lời bài hát'
                                  : 'Hiện lời bài hát'),
                              value: 1,
                            ),
                            const PopupMenuItem(
                                child: Text('Thêm vào playlist'), value: 2),
                            const PopupMenuItem(
                              child: Text('Tải về máy'),
                              value: 3,
                            ),
                          ],
                          onSelected: (value) {
                            switch (value) {
                              case 1:
                                setState(() {
                                  controller.isShowingLyrics =
                                      !controller.isShowingLyrics;
                                });
                                break;
                              case 2:
                                break;
                              case 3:
                                break;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  controller.isShowingLyrics
                      ? Container(
                          height: screenWidth,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: SingleChildScrollView(
                            child: Text(
                              playingMusic.lyrics ??
                                  'Lời bài hát đang cập nhật!',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(playingMusic.imageUrl),
                          radius: screenWidth / 3.2),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 45),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SeekBar(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 26,
                              icon: Icon(
                                Icons.shuffle_rounded,
                                color: controller.shuffleMode
                                    ? activeColor
                                    : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  controller.toggleShuffle();
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_previous_rounded),
                              iconSize: 34,
                              color: Colors.white,
                              onPressed: () {
                                controller.playPrevious();
                              },
                            ),
                            IconButton(
                              icon: Icon(controller.state == PlayerState.PLAYING
                                  ? Icons.pause_circle_outline_rounded
                                  : Icons.play_circle_outline_rounded),
                              iconSize: 75,
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  controller.togglePlay();
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.skip_next_rounded,
                              ),
                              iconSize: 34,
                              color: Colors.white,
                              onPressed: () {
                                controller.playNext();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                controller.repeatMode == RepeatMode.off
                                    ? Icons.repeat_rounded
                                    : (controller.repeatMode == RepeatMode.one
                                        ? Icons.repeat_one_rounded
                                        : Icons.repeat_rounded),
                              ),
                              iconSize: 26,
                              color: controller.repeatMode == RepeatMode.off
                                  ? Colors.white
                                  : activeColor,
                              onPressed: () {
                                setState(() {
                                  controller.toggleRepeat();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]);
          }),
    );
  }
}
