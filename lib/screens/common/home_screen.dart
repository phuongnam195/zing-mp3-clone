import 'package:flutter/material.dart';

import '../../providers/music_provider.dart';
import '../../providers/playing_log_provider.dart';
import '../../providers/playlist_provider.dart';
import '../../providers/ranked_music_provider.dart';
import '../../utils/config.dart';
import '../../controllers/player_controller.dart';
import '../../pages/chart_page.dart';
import '../../pages/explorer_page.dart';
import '../../pages/personal_page.dart';
import '../../pages/radio_page.dart';
import '../auth/login_screen.dart';
import 'account_screen.dart';
import 'search_screen.dart';
import '../../widgets/common/playing_control_bar.dart';
import '../../widgets/search/search_box.dart';

bool isFetched = false;

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentPageIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);
  final PlayerController playerController = PlayerController.instance;

  void _switchPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Future<void> fetchData() async {
    await MusicProvider.instance.fetchAndSetData();
    await PlaylistProvider.instance.fetchAndSetData();
    await PlayingLogProvider.instance.fetchAndSetData();
    await RankedMusicProvider.instance.countAndSort();
    setState(() {
      isFetched = true;
    });
  }

  @override
  void didChangeDependencies() {
    if (!isFetched) {
      fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _currentPageIndex == 3
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () {
                  if (Config.instance.myAccount != null) {
                    Navigator.of(context).pushNamed(AccountScreen.routeName);
                  } else {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  }
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
      body: isFetched
          ? PageView(
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
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: StreamBuilder<void>(
          stream: PlayerController.instance.onMusicChanged,
          builder: (context, snapshot) {
            return SizedBox(
              height: _currentPageIndex != 2 && playerController.isActive
                  ? 60 * 2
                  : 60,
              child: Column(
                children: [
                  if (_currentPageIndex != 2 && playerController.isActive)
                    const PlayingControlBar(),
                  BottomNavigationBar(
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Theme.of(context).hintColor,
                    selectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.w600),
                    currentIndex: _currentPageIndex,
                    onTap: _switchPage,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.library_music_outlined),
                          label: 'Cá nhân'),
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
            );
          }),
    );
  }
}
