import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ExplorerPlaylistCard extends StatelessWidget {
  const ExplorerPlaylistCard(
      {Key? key, required this.title, required this.thumbnailUrl, this.onTap})
      : super(key: key);

  final String title;
  final String thumbnailUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fakeTitle = title + '\n'; // mục đích: minLines = 2

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: thumbnailUrl,
              height: screenWidth / 2.6,
              width: screenWidth / 2.6,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: screenWidth / 2.6,
            child: Text(
              fakeTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
