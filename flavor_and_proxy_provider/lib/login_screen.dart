import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flavor & Provider'),
      ),
      body: Center(
          child: RaisedButton(
        onPressed: () {},
        child: Text('LOGIN'),
      )),
    );
  }
}
