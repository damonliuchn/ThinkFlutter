@JS()
library JSHelper;

import 'package:js/js.dart';

@JS()
external String invokeMethodFromFlutter(String method);

class PlatformWrap {
  static final bool isWeb = true;
  static final bool isLinux = false;
  static final bool isMacOS = false;
  static final bool isWindows = false;
  static final bool isAndroid = false;
  static final bool isIOS = false;
  static final bool isFuchsia = false;
}