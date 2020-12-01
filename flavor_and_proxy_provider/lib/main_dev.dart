import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flavor_and_provider/main.dart';
import 'package:flutter_flavor_and_provider/providers/app_config.dart';

void main() {
  const String kPort = '3010';
  final String baseUrl =
      Platform.isAndroid ? 'http://10.0.2.2:$kPort' : 'http://localhost:$kPort';
  final String dataUrl = '$baseUrl/dev';

  final appConfig = Appconfig(
    baseUrl: baseUrl,
    dataUrl: dataUrl,
    buildFlavor: 'dev',
  );

  runApp(MyApp(appConfig));
}
