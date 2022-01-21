import 'package:flutter/material.dart';

import '../controllers/player_controller.dart';
import '../providers/radio_provider.dart';
import '../widgets/radio/channel_card.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final channels = RadioProvider.instance.channels;

    return Stack(children: [
      Image.asset('assets/images/radio/radio_background.jpg',
          fit: BoxFit.fitWidth),
      Center(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            childAspectRatio: 0.95,
          ),
          itemCount: channels.length,
          itemBuilder: (ctx, index) {
            final channel = channels[index];
            return GestureDetector(
              child: ChannelCard(
                channel,
                isStreaming: index == RadioProvider.instance.current,
              ),
              onTap: () {
                if (PlayerController.instance.isPlaying) {
                  PlayerController.instance.togglePlay();
                }
                setState(() {
                  RadioProvider.instance.play(index);
                });
              },
            );
          },
          padding:
              EdgeInsets.only(top: screenHeight * 0.22, left: 20, right: 20),
        ),
      ),
    ]);
  }
}
