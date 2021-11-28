import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/data/all_musics.dart';

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AllMusics.instance.fetchAndSetData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Lỗi tải danh sách nhạc'));
          }

          final allMusics = AllMusics.instance.list;
          return ListView.builder(
            itemCount: allMusics.length,
            itemBuilder: (ctx, index) {
              final music = allMusics[index];
              return Column(
                children: [
                  Text(music.id),
                  Text(music.title),
                  Text(music.artists),
                  Image.network(
                    music.imageUrl,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  Text(music.audioUrl),
                  Text(music.duration.toString()),
                  const Divider(),
                ],
              );
            },
          );
        });
  }
}
