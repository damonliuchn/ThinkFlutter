import 'package:flutter/material.dart';
import 'package:flutter_mobx_project/second_page.dart';

class AppRoute {
  static final Map<String, WidgetBuilder> routes = {
    '/second': (_) => SecondPage(),
  };
}
