import 'dart:io'; // dart:io 不支持 web

String invokeMethodFromFlutter(String method) {
  return "";
}

class PlatformWrap {
  static final bool isWeb = false;
  static final bool isLinux = Platform.isLinux;
  static final bool isMacOS = Platform.isMacOS;
  static final bool isWindows = Platform.isWindows;
  static final bool isAndroid = Platform.isAndroid;
  static final bool isIOS = Platform.isIOS;
  static final bool isFuchsia = Platform.isFuchsia;
}
