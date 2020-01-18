

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gank_flutter/util/web/web_util_fake.dart'
    if (dart.library.js) 'package:gank_flutter/util/web/web_util.dart';


class HostUtil {
  static const _nativeCommonChannel =
      const MethodChannel("native_common_channel");

  static void systemNavigatorPop() {
    if (isAndroid()) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (isIOS()) {
      try {
        _nativeCommonChannel.invokeMethod("systemNavigatorPop");
      } catch (e) {}
    }
  }

  static void setSystemUIOverlayStyle() {
    if (isAndroid()) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  static Future<String> invokeMethod(String method, [dynamic arguments]) async {
    if (isAndroid() || isIOS()) {
      return HostUtil._nativeCommonChannel.invokeMethod(method, arguments);
    } else if (isWeb()) {
      return invokeMethodFromFlutter(method);
    }
  }

  static bool isAndroid() {
    return PlatformWrap.isAndroid;
  }

  static bool isIOS() {
    return PlatformWrap.isIOS;
  }

  static bool isWeb() {
    return PlatformWrap.isWeb;
  }
}
