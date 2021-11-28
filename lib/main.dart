import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/data/all_musics.dart';
import 'package:zing_mp3_clone/screens/common/account_screen.dart';
import 'package:zing_mp3_clone/screens/auth/forgot_screen.dart';
import 'package:zing_mp3_clone/screens/auth/login_screen.dart';
import 'package:zing_mp3_clone/screens/auth/signup_screen.dart';
import 'package:zing_mp3_clone/screens/common/search_screen.dart';
import 'package:zing_mp3_clone/screens/common/welcome_screen.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/common/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Zing MP3',
        theme: ThemeData(
          primaryColor: const Color(0xFF6E1694),
          hintColor: const Color(0xFF7C7C7C),
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
        });
  }
}
