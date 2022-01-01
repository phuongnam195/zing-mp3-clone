import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/playlist.dart';

class PersonalPlaylistCard extends StatelessWidget {
  const PersonalPlaylistCard(this.playlist, {Key? key}) : super(key: key);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: playlist.getMusicAtIndex(0).thumbnailUrl,
            height: 56,
            width: 56,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                Image.asset('assets/icons/playlist_96.png'),
          )),
      title: Text(
        playlist.title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${playlist.musicIDs.length} bài',
      ),
    );
  }
}
