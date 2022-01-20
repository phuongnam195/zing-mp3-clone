import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../controllers/player_controller.dart';

class PlayingControlBar extends StatelessWidget {
  const PlayingControlBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerController = PlayerController.instance;

    return Container(
        height: 60,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(offset: Offset(0, -1), color: Colors.black12, blurRadius: 1)
        ]),
        child: InkWell(
          onTap: () {
            playerController.maximizeScreen(context);
          },
          child: StreamBuilder<void>(
              stream: playerController.onMusicChanged,
              builder: (ctx, snapshot) {
                final playingMusic = playerController.current;
                final isPlaying = playerController.state == PlayerState.PLAYING;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              NetworkImage(playingMusic!.thumbnailUrl),
                          radius: 23),
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(playingMusic.title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                        Text(playingMusic.artists,
                            style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded),
                      iconSize: 32,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        playerController.togglePlay();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next_rounded),
                      iconSize: 32,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        playerController.playNext();
                      },
                    ),
                    const SizedBox(width: 6),
                  ],
                );
              }),
        ));
  }
}
