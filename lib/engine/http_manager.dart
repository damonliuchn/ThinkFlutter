import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class HttpManager {
  //static const String BASE_URL ="http://127.0.0.1:3000/proxy/api";
  static const String BASE_URL ="http://gank.io/api";
  static const String PROXY_HOST = "192.168.10.10";
  static const String PROXY_PORT = "8888";
  static const CONNECT_TIMEOUT = 5000;
  static const RECEIVE_TIMEOUT = 3000;
  static Dio dio;

  static Dio getInstance() {
    if (dio == null) {
      var options = BaseOptions(
          baseUrl: BASE_URL,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT);
      dio = new Dio(options);
      if(dio.httpClientAdapter is DefaultHttpClientAdapter){
        //在这里配置 代理 用于抓包
//        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//            (client) {
//              client.findProxy = (uri) {
//                return "PROXY " + PROXY_HOST + ":" + PROXY_PORT;
//              };
//            }
//        ;
      }
      dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        return options;
      }, onResponse: (Response response) {
        return response;
      }, onError: (DioError error) {
        return error;
      }));
    }
    return dio;
  }

}
