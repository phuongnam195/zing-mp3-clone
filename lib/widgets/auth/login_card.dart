import 'package:flutter/material.dart';

import './auth_text_field.dart';

class LoginCard extends StatefulWidget {
  const LoginCard(this._onSubmit, {Key? key}) : super(key: key);

  final Future<bool> Function(String email, String password) _onSubmit;

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _canLogin = true;

  final _borderRadius = 16.0;

  Future<void> _login() async {
    setState(() {
      _canLogin = false;
    });
    final successed = await widget._onSubmit(
        _emailController.text.trim(), _passwordController.text.trim());
    if (!successed) {
      setState(() {
        _canLogin = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthTextField(
            controller: _emailController,
            labelText: 'Địa chỉ email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_borderRadius),
              topRight: Radius.circular(_borderRadius),
            ),
          ),
          const SizedBox(height: 4),
          AuthTextField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            labelText: 'Mật khẩu',
            onSubmitted: (_) async {
              if (_canLogin) {
                await _login();
              }
            },
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(_borderRadius),
              bottomRight: Radius.circular(_borderRadius),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            child: const Text(
              'ĐĂNG NHẬP',
            ),
            onPressed: (!_canLogin)
                ? null
                : () async {
                    await _login();
                  },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 17),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: _canLogin ? FontWeight.w500 : FontWeight.w400,
                ),
                primary: Theme.of(context).primaryColor,
                onPrimary: Colors.white,
                shadowColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                shape: const StadiumBorder(),
                fixedSize: Size.fromWidth(screenWidth - 2 * 30)),
          ),
        ],
      ),
    );
  }
}
