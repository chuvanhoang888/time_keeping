// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkImage _$WorkImageFromJson(Map<String, dynamic> json) => WorkImage(
      id: json['id'] as int?,
      workId: json['work_id'] as int?,
      path: json['path'] as String?,
      images: json['photo'] as String?,
      state: json['state'] as int? ?? 0,
    );

Map<String, dynamic> _$WorkImageToJson(WorkImage instance) => <String, dynamic>{
      'id': instance.id,
      'work_id': instance.workId,
      'path': instance.path,
      'photo': instance.images,
      'state': instance.state,
    };
