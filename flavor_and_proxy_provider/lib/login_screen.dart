import 'package:flavor_and_proxy_provider/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flavor_and_proxy_provider/providers/auth.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _submitting = false;
  bool _checkingLoggedIn = true;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  _checkLoggedIn() async {
    try {
      final bool isLoggedIn =
          await Provider.of<AuthProvider>(context, listen: false)
              .tryAutoLogin();
      print(isLoggedIn);
      if (isLoggedIn) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      } else {
        setState(() => _checkingLoggedIn = false);
      }
    } catch (e) {
      print(e);
      setState(() => _checkingLoggedIn = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Flavor & Provider Checking.....'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Flavor & Provider'),
      ),
      body: Center(
          child: _submitting
              ? Center(child: CircularProgressIndicator())
              : RaisedButton(
                  child: Text('LOGIN'),
                  onPressed: () {
                    try {
                      setState(() => _submitting = true);

                      Provider.of<AuthProvider>(context, listen: false).login();

                      setState(() => _submitting = false);

                      // 로그인 이후에는 뒤로 다시 돌아올일이 없으므로 pushReplacementNamed 를 사용
                      Navigator.of(context)
                          .pushReplacementNamed(DashboardScreen.routeName);
                    } catch (e) {
                      print(e);

                      setState(() => _submitting = false);
                    }
                  },
                )),
    );
  }
}
