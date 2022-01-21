import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  const MusicCard(
      {Key? key,
      required this.title,
      required this.artists,
      required this.thumbnailUrl,
      this.onTap})
      : super(key: key);

  final String title;
  final String artists;
  final String thumbnailUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: thumbnailUrl,
          height: 56,
          width: 56,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) =>
              Image.asset('assets/icons/non_thumb_music_100.jpg'),
        ),
      ),
      minLeadingWidth: 56,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(artists),
      onTap: onTap,
    );
  }
}
