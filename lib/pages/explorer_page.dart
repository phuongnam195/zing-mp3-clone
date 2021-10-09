import 'package:flutter/material.dart';

class ExplorerPage extends StatelessWidget {
  final Function startToPlayMusic;

  const ExplorerPage(this.startToPlayMusic, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: ListTile(
            leading: Image.network(
                'https://avatar-ex-swe.nixcdn.com/song/2021/01/22/9/f/2/1/1611280898757_500.jpg'),
            title: const Text('Hương'),
            subtitle: const Text('Văn Mai Hương, Negav'),
          ),
          onTap: () => startToPlayMusic(),
        ),
        const Divider(
          height: 0,
        ),
      ],
    );
  }
}
