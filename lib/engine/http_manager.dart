import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:gank_flutter/bu/home/model/article.dart';
import 'package:gank_flutter/model/http_result.dart';

class HttpManager {
  //static const String BASE_URL ="http://127.0.0.1:3000/proxy/api";
  static const String BASE_URL = "http://gank.io/api";
  static const String PROXY_HOST = "192.168.10.10";
  static const String PROXY_PORT = "8888";
  static const CONNECT_TIMEOUT = 40000;
  static const RECEIVE_TIMEOUT = 40000;
  static Dio dio;

  static Dio getInstance() {
    if (dio == null) {
      var options = BaseOptions(
          baseUrl: BASE_URL,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT);
      dio = new Dio(options);
      if (dio.httpClientAdapter is DefaultHttpClientAdapter) {
        //在这里配置 代理 用于抓包
//        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//            (client) {
//          client.findProxy = (uri) {
//            return "PROXY 192.168.1.8:8888";
//          };
//        };
      }
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        return options;
      }, onResponse: (Response response) {
        return response;
      }, onError: (DioError error) {
        return error;
      }));
    }
    return dio;
  }

  static Future<T>   request<T extends HttpResult> (Future<T> future, bool loading) async{
    if (loading != null && loading) {
      BotToast.showLoading();
    }
    T article;
    try{
      article = await future;
      if(article.error){
        BotToast.showText(text: "服务器错误");
      }
    }catch(e){
      if (e is DioError) {
        BotToast.showText(text: e.message);
      } else {
        BotToast.showText(text: e.toString());
      }
    }
    if (loading != null && loading) {
      BotToast.closeAllLoading();
    }
    return article;
  }

  /** 轮询 **/
  static void polling(Function futureFactory, bool loading, int totalCount, int totalTime,
      Function checkSuccess, Function success, Function failure) {
    _polling(futureFactory,loading,totalCount,totalCount,DateTime.now().millisecondsSinceEpoch,totalTime,checkSuccess,success,failure);
  }
  static void _polling(
      Function futureFactory,
      bool loading,
      int currentCount,
      int totalCount,
      int startTime,
      int totalTime,
      Function checkSuccess,
      Function success,
      Function failure) {
    if (loading != null && loading && currentCount == totalCount) {
      BotToast.showLoading();
    }
    futureFactory().then((result) {
      if (checkSuccess(result)) {
        //符合条件了 停止轮询 成功
        if (success != null) {
          success(result);
        }
        if (loading != null && loading) {
          BotToast.closeAllLoading();
        }
      } else {
        throw Error();
      }
    }).catchError((e) {
      currentCount--;
      if (currentCount == 0 || DateTime.now().millisecondsSinceEpoch - startTime > totalTime) {
        //print("ddddd"+ (DateTime.now().millisecondsSinceEpoch - startTime).toString()  + totalTime.toString() + "ddddd"+currentCount.toString());
        if (failure != null) {
          failure();
        }
        //达到上限 停止轮询 失败
        if (loading != null && loading) {
          BotToast.closeAllLoading();
        }
      } else {
        //轮询
        _polling(futureFactory, loading, currentCount, totalCount, startTime, totalTime,
            checkSuccess, success, failure);
      }
    });
  }

  /** 上传 **/
  static void upload(File imgfile, bool loading, Function success) {
    if (loading != null && loading) {
      BotToast.showLoading();
    }
    _upload(imgfile).then((result) {
      if(success!=null){
        success(result);
      }
      if (loading != null && loading) {
        BotToast.closeAllLoading();
      }
    }).catchError((e) {
      if (e is DioError) {
        BotToast.showText(text: e.message);
      } else {
        BotToast.showText(text: e.toString());
      }
      if (loading != null && loading) {
        BotToast.closeAllLoading();
      }
    });
  }
  static Future _upload(imgfile) async {
    var fileDir = imgfile.path;
    //注意：dio3.x版本为了兼容web做了一些修改，上传图片的时候需要把File类型转换成String类型
    FormData formData = FormData.fromMap({
      "name": "TestUpload",
      "file":  await MultipartFile.fromFile(fileDir)
    });
    final Response<Map<String, dynamic>> _result = await HttpManager.getInstance().post("http://httpbin.org/post", data: formData);
    return Future.value(_result.data);
  }
}
