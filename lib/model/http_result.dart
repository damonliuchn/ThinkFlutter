import 'package:json_annotation/json_annotation.dart';
import 'package:gank_flutter/bu/home/model/article.dart';

part 'http_result.g.dart';
@JsonSerializable()
class HttpResult {
  //List<Article> results;
  bool error;
  bool error22;
  HttpResult();
  factory HttpResult.fromJson(Map<String, dynamic> json) => $HttpResultFromJson(json);
  Map<String, dynamic> toJson() => _$HttpResultToJson(this);
}
