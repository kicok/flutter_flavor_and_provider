import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = 'dashboard';
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flavor & Provider'),
      ),
      body: Center(
          child: RaisedButton(
        onPressed: () {},
        child: Text('DashBoard'),
      )),
    );
  }
}
