import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
typedef DeserializeFunc = dynamic Function(Map<String,dynamic> map);

class SpUtil{
  static SharedPreferences preferences;
  static Map<String, dynamic> _objectCache = {};
  static Future<bool> open() async{
    preferences = await SharedPreferences.getInstance();
    return true;
  }

  static void setString(String key,String value) {
    preferences.setString(key, value);
  }

  static void getString(String key) {
    preferences.getString(key);
  }

  static void remove(String key) {
    preferences.remove(key);
  }

  static void setObject(String key,dynamic dy) {
    if(_objectCache.containsKey(key)) _objectCache.remove(key);
    if(dy == null){
      if(preferences.containsKey(key)) preferences.remove(key);
    }else{
      _objectCache.putIfAbsent(key, () => dy);
      try{
        String jsonString = jsonEncode(dy.toJson());
        preferences.setString(key, jsonString);
      }catch(e){}
    }
  }

  static dynamic getObject(String key,DeserializeFunc deserializeFunc) {
    if(_objectCache.containsKey(key)){
      return _objectCache[key];
    }else{
      try{
        dynamic dyMap = jsonDecode(preferences.getString(key));
        dynamic dy = deserializeFunc(dyMap);
        _objectCache.putIfAbsent(key, () => dy);
        return dy;
      }catch(e){}
      return null;
    }
  }
}