import 'package:flutter/material.dart';

import '../controllers/player_controller.dart';
import '../providers/music_provider.dart';
import '../widgets/common/music_card.dart';

class RadioPage extends StatelessWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allMusics = MusicProvider.instance.list;
    return ListView.builder(
      itemCount: allMusics.length,
      itemBuilder: (ctx, index) {
        final music = allMusics[index];
        return MusicCard(
          title: music.title,
          artists: music.artists,
          thumbnailUrl: music.thumbnailUrl,
          onTap: () {
            PlayerController.instance.setMusic(music);
          },
        );
      },
    );
  }
}
