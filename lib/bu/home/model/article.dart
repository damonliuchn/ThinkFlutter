import 'package:gank_flutter/model/http_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';
@JsonSerializable()
class Article {
  String createdAt;
  List<String> images;
  String publishedAt;
  String source;
  bool used;
  String type;
  String url;
  String desc;
  String who;
  Article({this.createdAt, this.images, this.publishedAt, this.source, this.used, this.type, this.url, this.desc, this.who});
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

}

@JsonSerializable()
class HttpArticle extends HttpResult{
  List<Article> results;
  HttpArticle({this.results});
  factory HttpArticle.fromJson(Map<String, dynamic> json) => _$HttpArticleFromJson(json);
  Map<String, dynamic> toJson() => _$HttpArticleToJson(this);
}
