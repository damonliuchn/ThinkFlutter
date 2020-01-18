import 'package:bot_toast/bot_toast.dart';
import 'package:gank_flutter/main.dart';
//import 'package:toast/toast.dart';

class ToastUtil {
  static void show(Object msg) {
//    Toast.show(msg, MyApp.buildContext,
//        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    BotToast.showText(text:msg);
  }
}
