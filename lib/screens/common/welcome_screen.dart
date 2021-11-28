import 'package:flutter/material.dart';
import 'package:zing_mp3_clone/screens/auth/login_screen.dart';
import 'package:zing_mp3_clone/screens/common/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
