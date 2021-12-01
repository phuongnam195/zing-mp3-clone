import 'package:flutter/material.dart';

import '../auth/login_screen.dart';
import './home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ảnh nền: AssetImage('assets/images/auth/welcome_background.jpg')
    // Answer thứ 2: https://stackoverflow.com/questions/54241753/background-image-for-scaffold

    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
            child: Text('SỬ DỤNG TÀI KHOẢN'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
            child: Text('BỎ QUA'),
          ),
        ],
      ),
    );
  }
}
