// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as int?,
      workId: json['work_id'] as int?,
      content: json['content'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'work_id': instance.workId,
      'content': instance.content,
      'status': instance.status,
    };
