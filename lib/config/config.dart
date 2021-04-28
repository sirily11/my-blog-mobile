import 'package:envify/envify.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';

class Config {
  static String base =
      kDebugMode ? FlutterConfig.get("DBASE") : FlutterConfig.get("BASE");
  static const memoryURL = "blog/memory/";
  static const memoryImageURL = "blog/memory-image/";
  static const memoryVideoURL = "blog/memory-video/";
  static const authURL = "api/token/";
}
