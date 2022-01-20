import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../providers/radio_provider.dart';

class ChannelCard extends StatelessWidget {
  ChannelCard(this.channel, {Key? key, this.isStreaming = false})
      : super(key: key);

  final Channel channel;
  bool isStreaming;

  @override
  Widget build(BuildContext context) {
    final LIVE_COLOR = Colors.red;

    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: screenWidth * 0.35,
              height: screenWidth * 0.35,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: LIVE_COLOR, width: 4),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(channel.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isStreaming)
              Container(
                  width: screenWidth * 0.35,
                  height: screenWidth * 0.35,
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                    border: Border.all(color: LIVE_COLOR, width: 4),
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.pause,
                    size: 70,
                    color: Colors.white70,
                  ))),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: LIVE_COLOR,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          channel.title,
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
