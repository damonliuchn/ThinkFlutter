import 'package:dio/dio.dart' hide Headers;
import 'package:gank_flutter/bu/home/model/article.dart';
import 'package:gank_flutter/engine/http_manager.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api.g.dart';

@RestApi()
abstract class HomeApi {
  //factory HomeApi(Dio dio, {String baseUrl}) = _HomeApi;
  factory HomeApi() => _HomeApi(HttpManager.getInstance());

  //todo 下面代码在web中为null
  //static final HomeApi instance = _HomeApi(HttpManager.getInstance());

  @GET("/data/{cate}/10/{page}")
  Future<HttpArticle> getTasks(@Path("cate") String cate,@Path("page") String page);

}
