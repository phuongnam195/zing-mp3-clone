import 'package:flutter/material.dart';

class LibraryPlaylistCard extends StatelessWidget {
  const LibraryPlaylistCard(
      {Key? key,
      required this.title,
      required this.iconAsset,
      required this.width})
      : super(key: key);

  final String title;
  final String iconAsset;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  iconAsset,
                  width: 32,
                  height: 32,
                ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
          )),
    );
  }
}
