import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/config.dart';

import '../../controller/player_controller.dart';
import '../../pages/chart_page.dart';
import '../../pages/explorer_page.dart';
import '../../pages/personal_page.dart';
import '../../pages/radio_page.dart';
import '../auth/login_screen.dart';
import './account_screen.dart';
import './search_screen.dart';
import '../../widgets/common/playing_control_bar.dart';
import '../../widgets/search/search_box.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      bottomNavigationBar: StreamBuilder<void>(
          stream: PlayerController.instance.onChange,
          builder: (context, snapshot) {
            return SizedBox(
              height: playerController.isActive ? 60 * 2 : 60,
              child: Column(
                children: [
                  if (playerController.isActive) const PlayingControlBar(),
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