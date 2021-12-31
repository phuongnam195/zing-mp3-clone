import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import './welcome_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget settingItem(String title, IconData icon, void Function() onTap) {
      return ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
          size: 28,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        onTap: onTap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.keyboard_backspace_rounded,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
        title: const Text(
          'Tài khoản cá nhân',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF65509E), Color(0xFF8947AD)])),
              child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  leading: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/account/avatar.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(23),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.5,
                      ),
                    ),
                  ),
                  title: Text(
                    Config.instance.myAccount!.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))),
          const SizedBox(height: 40),
          settingItem('Đăng xuất', Icons.logout, () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                WelcomeScreen.routeName, (Route<dynamic> route) => false);
            FirebaseAuth.instance.signOut();
          }),
          settingItem('Giới thiệu', Icons.info_outline_rounded, () {}),
        ],
      ),
    );
  }
}
