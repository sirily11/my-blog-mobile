import 'package:envify/envify.dart';
import 'package:flutter/foundation.dart';

part 'env.g.dart';

@Envify(path: kReleaseMode ? ".env.release" : ".env.development")
abstract class Env {
  /// Base URL for the fetcher
  static const base = _Env.base;
  static const memoryURL = "blog/memory/";
  static const memoryImageURL = "blog/memory-image/";
  static const memoryVideoURL = "blog/memory-video/";
  static const authURL = "api/token/";
}
