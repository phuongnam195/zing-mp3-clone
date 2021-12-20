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
    body:Stack(
      children: <Widget>[
        Image.asset(
          "images/auth/welcome_background.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
                
            ),
            bottomNavigationBar: Container(
              height: 60.0 + MediaQuery.of(context).padding.bottom,
            ),
            body: Column(
              children: <Widget>[
                Container(
                  color:Colors.blue,
                    child: Padding(
                  padding: EdgeInsets.only(
                    top: 80.0,
                    left:40.0,
                    right:40.0,
                  ),
                  child: new Text(
                      "Chào mừng đến với ứng dụng nghe nhạc trực tuyến",
                      
                      style: new TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )),
                const Spacer(),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 80.0,
                            right: 80.0,
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: Text('SỬ DỤNG TÀI KHOẢN',
                              style: TextStyle(fontSize: 20)),
                        )),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(HomeScreen.routeName);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 80.0,
                          right: 80.0,
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        child: Text(
                          'BỎ QUA',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    ),
 );
  }
}
