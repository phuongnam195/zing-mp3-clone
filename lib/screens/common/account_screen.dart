import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import './welcome_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.keyboard_backspace_rounded),
        ),
        title: Text('Tài khoản cá nhân'),
      ),
      body: Column(
        children: [
          Text(Config.instance.myAccount!.name),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(WelcomeScreen.routeName));

                FirebaseAuth.instance.signOut();
              },
              child: Text('ĐĂNG XUẤT'))
        ],
      ),
    );
  }
}
