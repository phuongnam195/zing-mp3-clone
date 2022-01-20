import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RankedMusicCard extends StatelessWidget {
  const RankedMusicCard({
    Key? key,
    required this.order,
    required this.title,
    required this.artists,
    required this.thumbnailUrl,
    this.orderColor,
    this.orderWidth,
  }) : super(key: key);

  final int order;
  final String title;
  final String artists;
  final String thumbnailUrl;
  final Color? orderColor;
  final double? orderWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: orderWidth ?? 46,
            child: Center(
                child: Text(
              '$order',
              style: TextStyle(
                  color: orderColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ))),
        Expanded(
          child: ListTile(
            minLeadingWidth: 46,
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: thumbnailUrl,
                height: 46,
                width: 46,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            subtitle: Text(
              artists,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
