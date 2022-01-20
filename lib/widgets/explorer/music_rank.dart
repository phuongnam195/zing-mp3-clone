import 'package:flutter/material.dart';

import '../../controllers/player_controller.dart';
import '../../providers/music_provider.dart';
import '../../providers/ranked_music_provider.dart';
import '../../models/music.dart';
import '../common/ranked_music_card.dart';

class MusicRank extends StatefulWidget {
  const MusicRank({Key? key}) : super(key: key);

  @override
  State<MusicRank> createState() => _MusicRankState();
}

class _MusicRankState extends State<MusicRank> {
  static const CORNER_RADIUS = Radius.circular(5);

  List<Music> top5Days = [];
  List<Music> top5Weeks = [];
  List<Music> top5Totals = [];

  int _currentTab = 0;

  Widget tab(int index, String text) {
    bool isSelected = (index == _currentTab);
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (!isSelected) {
            setState(() {
              _currentTab = index;
            });
          }
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(vertical: 8),
            primary: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            onPrimary: isSelected ? null : Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: CORNER_RADIUS,
              topRight: CORNER_RADIUS,
            ))),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final dayRanks = RankedMusicProvider.instance.dayRanks;
    for (int i = 0; i < 5 && i < dayRanks.length; i++) {
      top5Days.add(MusicProvider.instance.getByID(dayRanks[i].musicId));
    }

    final weekRanks = RankedMusicProvider.instance.weekRanks;
    for (int i = 0; i < 5 && i < weekRanks.length; i++) {
      top5Weeks.add(MusicProvider.instance.getByID(weekRanks[i].musicId));
    }

    final totalRanks = RankedMusicProvider.instance.totalRanks;
    for (int i = 0; i < 5 && i < totalRanks.length; i++) {
      top5Totals.add(MusicProvider.instance.getByID(totalRanks[i].musicId));
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentList = top5Days;
    if (_currentTab == 1) {
      currentList = top5Weeks;
    } else if (_currentTab == 2) {
      currentList = top5Totals;
    }

    final playerController = PlayerController.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              tab(0, 'NGÀY'),
              tab(1, 'TUẦN'),
              tab(2, 'TOÀN BỘ'),
            ],
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: CORNER_RADIUS, bottomRight: CORNER_RADIUS),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      const Color(0xFF230E28)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  for (int i = 0; i < currentList.length; i++)
                    InkWell(
                      child: RankedMusicCard(
                        order: i + 1,
                        title: currentList[i].title,
                        artists: currentList[i].artists,
                        thumbnailUrl: currentList[i].thumbnailUrl,
                      ),
                      onTap: () {
                        if (!playerController.isActive) {
                          playerController.maximizeScreen(context);
                        }
                        playerController.setMusicList(currentList, index: i);
                        playerController.notifyMusicChange();
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 40,
                      child: FittedBox(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Xem thêm'),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.transparent,
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: Colors.white.withOpacity(0.8))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
