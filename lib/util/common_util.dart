import 'package:event_bus/event_bus.dart';

class CommonUtil{
  static final EVENTBUS = EventBus();
  static bool check(bool b) {
    if (b != null && b) {
      return true;
    } else {
      return false;
    }
  }
}

