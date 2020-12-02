import 'package:flavor_and_proxy_provider/providers/app_config.dart';
import 'package:flavor_and_proxy_provider/providers/auth.dart';
import 'package:flavor_and_proxy_provider/providers/get_data.dart';
import 'package:flutter/material.dart';

import 'package:flavor_and_proxy_provider/dashboard_screen.dart';
import 'package:flavor_and_proxy_provider/login_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final appConfiguration;

  MyApp(this.appConfiguration);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 다른곳에서 만들어지지 않고 여기서 만들때는 create를 써라.
        // 다른곳에서 만들어진 클래스의 값을 활용할때는 create가 아닌 value를 사용하라.
        Provider<AppConfig>.value(value: appConfiguration),

        //<AppConfig, AuthProvider> 앞에 있는 타입이 뒤에 있는 타입에 의존함
        ChangeNotifierProxyProvider<AppConfig, AuthProvider>(
          create: (_) => AuthProvider(),
          update: (_, appConfig, authProvider) {
            authProvider.appConfig = appConfig;

            return authProvider;
          },
        ),

        // auth뿐만 아니라 getData의 value 값을 만든다.
        ChangeNotifierProxyProvider2<AppConfig, AuthProvider, GetDataProvider>(
          create: (_) => GetDataProvider(),
          update: (_, appConfig, auth, getDataProvider) {
            getDataProvider.appConfig = appConfig;
            getDataProvider.auth = auth;
            return getDataProvider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          DashboardScreen.routeName: (context) => DashboardScreen(),
        },
      ),
    );
  }
}
