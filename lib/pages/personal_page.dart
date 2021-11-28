import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/data/all_playlists.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AllPlaylists.instance.fetchAndSetData(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Lỗi tải danh sách playlist'));
        }

        final allPlaylists = AllPlaylists.instance.list;
        return ListView.builder(
          itemCount: allPlaylists.length,
          itemBuilder: (ctx, index) {
            final playlist = allPlaylists[index];
            return Column(
              children: [
                Text(playlist.id),
                Text(playlist.title),
                Image.network(
                  playlist.imageUrl!,
                  width: 300,
                  fit: BoxFit.cover,
                ),
                for (var musicId in playlist.musicIDs) Text(musicId),
                const Divider(),
              ],
            );
          },
        );
      },
    );
  }
}
