// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResult $HttpResultFromJson(Map<String, dynamic> json) {
  return HttpResult()
    ..error = json['error'] as bool
    ..error22 = json['error22'] as bool;
}

Map<String, dynamic> _$HttpResultToJson(HttpResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error22': instance.error22,
    };
