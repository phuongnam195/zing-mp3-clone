import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/controller/player_controller.dart';
import 'package:zing_mp3_clone/providers/music_provider.dart';
import 'package:zing_mp3_clone/widgets/common/music_card.dart';

import '../../providers/recent_search_provider.dart';
import '../../models/music.dart';
import '../../widgets/search/search_box.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/home/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Music> recentList = [];
  List<Music>? resultList;

  @override
  void initState() {
    super.initState();
    recentList = RecentSearchProvider.instance.list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.black,
            icon: const Icon(Icons.keyboard_backspace_rounded),
          ),
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SearchBox(
              autofocus: true,
              onSubmitted: (value) {
                setState(() {
                  resultList = MusicProvider.instance.search(value);
                });
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: resultList == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tìm kiếm gần đây',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    for (var music in recentList)
                      MusicCard(
                          title: music.title,
                          artists: music.artists,
                          thumbnailUrl: music.thumbnailUrl)
                  ],
                )
              : ListView.builder(
                  itemCount: resultList!.length,
                  itemBuilder: (ctx, i) {
                    final music = resultList![i];
                    return MusicCard(
                      title: music.title,
                      artists: music.artists,
                      thumbnailUrl: music.thumbnailUrl,
                      onTap: () {
                        final controller = PlayerController.instance;
                        if (!controller.isActive) {
                          controller.maximizeScreen(context);
                        }
                        controller.setMusic(music);
                        RecentSearchProvider.instance.add(music.id);
                      },
                    );
                  }),
        ));
  }
}
