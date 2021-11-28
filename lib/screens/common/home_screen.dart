import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/pages/chart_page.dart';
import 'package:zing_mp3_clone/pages/explorer_page.dart';
import 'package:zing_mp3_clone/pages/personal_page.dart';
import 'package:zing_mp3_clone/pages/radio_page.dart';
import 'package:zing_mp3_clone/screens/common/account_screen.dart';
import 'package:zing_mp3_clone/screens/common/search_screen.dart';
import 'package:zing_mp3_clone/widgets/search/search_box.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentPageIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);
  final AudioPlayer audioPlayer = AudioPlayer();
  bool _startedToPlay = false;
  bool _isPlaying = false;

  void _switchPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _startToPlayMusic() {
    if (_startedToPlay) {
      return;
    }
    audioPlayer.play(
        'https://c1-ex-swe.nixcdn.com/NhacCuaTui1010/Huong-VanMaiHuongNegav-6927340.mp3?st=izwmKajfcKzjI5rfxSV-HQ&e=1633870096');
    setState(() {
      _startedToPlay = true;
      _isPlaying = true;
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AccountScreen.routeName);
            },
          ),
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SearchBox(
                enabled: false,
                onTap: () {
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                }),
          )),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: const [
          PersonalPage(),
          ExplorerPage(),
          ChartPage(),
          RadioPage(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: _startedToPlay ? 60 * 2 : 60,
        child: Column(
          children: [
            if (_startedToPlay)
              Container(
                color: Colors.green[100],
                height: kBottomNavigationBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                      onPressed: () {
                        if (_isPlaying) {
                          audioPlayer.pause();
                        } else {
                          audioPlayer.resume();
                        }
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.stop),
                      onPressed: () {
                        audioPlayer.stop();
                        setState(() {
                          _isPlaying = false;
                          _startedToPlay = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            BottomNavigationBar(
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.amber,
              currentIndex: _currentPageIndex,
              onTap: _switchPage,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_music_outlined), label: 'Cá nhân'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.album_outlined), label: 'Khám phá'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.insights_rounded), label: 'Chart'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.radio), label: 'Radio'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
