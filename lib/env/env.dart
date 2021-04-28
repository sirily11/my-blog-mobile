import 'package:envify/envify.dart';
import 'package:flutter/foundation.dart';

part 'env.g.dart';

@Envify(path: kReleaseMode ? ".env.release" : ".env.development")
abstract class Env {
  static const baseURL = _Env.baseURL;
}
