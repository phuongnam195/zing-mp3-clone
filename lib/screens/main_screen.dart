import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/pages/explorer_page.dart';
import 'package:zing_mp3_clone/pages/personal_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    const searchBarHeight = 30.0;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: () {},
          ),
          centerTitle: true,
          title: SizedBox(
            height: searchBarHeight,
            child: TextField(
              autofocus: false,
              textAlignVertical: TextAlignVertical.bottom,
              cursorColor: Theme.of(context).primaryColor,
              cursorWidth: 1.5,
              decoration: InputDecoration(
                hintText: 'Bài hát, playlist, nghệ sĩ...',
                hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
                prefixIcon:
                    Icon(Icons.search, color: Theme.of(context).hintColor),
                isDense: true,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(searchBarHeight / 2),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          )),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          const PersonalPage(),
          ExplorerPage(_startToPlayMusic),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: _startedToPlay
            ? kBottomNavigationBarHeight * 2
            : kBottomNavigationBarHeight,
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
              currentIndex: _currentPageIndex,
              onTap: _switchPage,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_music_outlined), label: 'Cá nhân'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.album_outlined), label: 'Khám phá')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
