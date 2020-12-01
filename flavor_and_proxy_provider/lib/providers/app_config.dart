import 'package:meta/meta.dart';

class Appconfig {
  final String baseUrl;
  final String dataUrl;
  final String buildFlavor;

  Appconfig({
    @required this.baseUrl,
    @required this.dataUrl,
    @required this.buildFlavor,
  });
}
