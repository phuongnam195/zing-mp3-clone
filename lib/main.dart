import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './data/all_musics.dart';
import './data/all_playlists.dart';
import './data/recent_searchs.dart';
import './providers/all_playing_logs.dart';
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

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await AllMusics.instance.fetchAndSetData();
  await AllPlaylists.instance.fetchAndSetData();
  if (FirebaseAuth.instance.currentUser != null) {
    await Config.instance.loadAccountData();
  }
  await RecentSearchs.instance.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AllPlayingLogs>(create: (_) => AllPlayingLogs()),
      ],
      child: MaterialApp(
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
          }),
    );
  }
}
