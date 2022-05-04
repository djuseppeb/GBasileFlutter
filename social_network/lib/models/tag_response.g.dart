// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagResponse _$TagResponseFromJson(Map<String, dynamic> json) => TagResponse(
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
    );

Map<String, dynamic> _$TagResponseToJson(TagResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
    };
