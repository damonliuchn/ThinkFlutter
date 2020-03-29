import 'package:gank_flutter/mobx/counter.dart';
import 'package:mobx/mobx.dart';

class StoreManager  {
    static final StoreManager _singleton = StoreManager._internal();
    factory StoreManager() {
        return _singleton;
    }
    Counter counter;
    StoreManager._internal(){
        counter = Counter();
    }
}