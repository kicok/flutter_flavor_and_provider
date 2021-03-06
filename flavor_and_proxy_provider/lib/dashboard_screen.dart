import 'package:flavor_and_proxy_provider/login_screen.dart';
import 'package:flavor_and_proxy_provider/providers/app_config.dart';
import 'package:flavor_and_proxy_provider/providers/auth.dart';
import 'package:flavor_and_proxy_provider/providers/get_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = 'dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Provider.of<GetDataProvider>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    final mode = Provider.of<AppConfig>(context);
    final message = Provider.of<GetDataProvider>(context)
        .message; //listen:false 필요하지 않음. getData 함수에서 정의된  _message 값을 가져오기만 하면 될뿐.. notifylistenr의 영향을 받지 않음.
    return Scaffold(
      appBar: AppBar(
        title: Text(
            mode.buildFlavor == 'dev' ? 'Dev DashBoard' : 'Prod Dashboard'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await Provider.of<AuthProvider>(
                  context,
                  listen: false,
                ).logout();

                //지금까지의 화면 스택을 모두 지우고 화면을 이동한다.
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (route) => false);
              })
        ],
      ),
      body: Center(
        child: Text('Message Received : $message'),
      ),
    );
  }
}
