import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'providers/ranked_musics.dart';
import 'providers/music_provider.dart';
import 'providers/playlist_provider.dart';
import './providers/recent_searchs.dart';
import 'providers/playing_log_provider.dart';
import './screens/common/account_screen.dart';
import './screens/auth/forgot_screen.dart';
import './screens/auth/login_screen.dart';
import './screens/auth/signup_screen.dart';
import './screens/common/playing_screen.dart';
import './screens/common/playlist_screen.dart';
import './screens/common/search_screen.dart';
import './screens/common/welcome_screen.dart';
import './config.dart';
import './screens/common/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await MusicProvider.instance.fetchAndSetData();
  await PlaylistProvider.instance.fetchAndSetData();
  await PlayingLogsProvider.instance.fetchAndSetData();
  await RankedMusicProvider.instance.process();
  if (FirebaseAuth.instance.currentUser != null) {
    await Config.instance.loadAccountData();
  }
  await RecentSearchProvider.instance.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Zing MP3',
        theme: ThemeData(
          primaryColor: const Color(0xFF814C9E),
          hintColor: const Color(0xFF797979),
          fontFamily: 'Open Sans',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.routeName,
        routes: {
          WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          SignUpScreen.routeName: (ctx) => const SignUpScreen(),
          ForgotScreen.routeName: (ctx) => const ForgotScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          AccountScreen.routeName: (ctx) => const AccountScreen(),
          SearchScreen.routeName: (ctx) => const SearchScreen(),
          PlayingScreen.routeName: (ctx) => const PlayingScreen(),
          PlaylistScreen.routeName: (ctx) => const PlaylistScreen(),
        });
  }
}
