import 'package:flutter/material.dart';

import '../auth/login_screen.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Image.asset(
          "assets/images/auth/welcome_background.jpg",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
                child: Text("Chào mừng đến với ứng dụng nghe nhạc trực tuyến",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  child: const Text('SỬ DỤNG TÀI KHOẢN',
                      style: TextStyle(fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF0091FF),
                    fixedSize: Size.fromWidth(screenWidth - 100),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  )),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                },
                child: const Text(
                  'BỎ QUA',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        )
      ],
    );
  }
}
