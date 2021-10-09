import 'package:flutter/material.dart';

import './screens/main_screen.dart';

void main() {
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
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
