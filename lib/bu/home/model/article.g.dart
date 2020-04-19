// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    createdAt: json['createdAt'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    publishedAt: json['publishedAt'] as String,
    source: json['source'] as String,
    used: json['used'] as bool,
    type: json['type'] as String,
    url: json['url'] as String,
    desc: json['desc'] as String,
    who: json['who'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'images': instance.images,
      'publishedAt': instance.publishedAt,
      'source': instance.source,
      'used': instance.used,
      'type': instance.type,
      'url': instance.url,
      'desc': instance.desc,
      'who': instance.who,
    };

HttpArticle _$HttpArticleFromJson(Map<String, dynamic> json) {
  return HttpArticle(
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..error = json['error'] as bool;
}

Map<String, dynamic> _$HttpArticleToJson(HttpArticle instance) =>
    <String, dynamic>{
      'error': instance.error,
      'results': instance.results,
    };
