import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';
import 'app_config.dart';

class GetDataProvider with ChangeNotifier {
  String _message;
  String get message => _message;

  AppConfig _appconfig;
  AppConfig get appConfig => _appconfig;

  set appConfig(AppConfig appconfigVal) {
    if (_appconfig != appconfigVal) {
      _appconfig = appconfigVal;
      notifyListeners();
    }
  }

  AuthProvider _auth;

  AuthProvider get auth => _auth;

  set auth(AuthProvider authVal) {
    if (_auth != authVal) {
      _auth = authVal;
      notifyListeners();
    }
  }

  Future<void> getData() async {
    try {
      final String url = '${appConfig.dataUrl}/login';

      final http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer ${auth.token}',
      });
      final responseData = json.decode(response.body);
      if (response.statusCode != 200 || !responseData['success']) {
        throw 'Fail to get data';
      }

      if (appConfig.buildFlavor == 'dev') {
        print(responseData);
      }

      _message = responseData['message'];

      notifyListeners();
    } catch (e) {
      if (appConfig.buildFlavor == 'dev') {
        print('error: $e');
      }
      throw e;
    }
  }
}
