// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkUser _$WorkUserFromJson(Map<String, dynamic> json) => WorkUser(
      id: json['id'] as int?,
      workId: json['work_id'] as int?,
      userId: json['user_id'] as int?,
    );

Map<String, dynamic> _$WorkUserToJson(WorkUser instance) => <String, dynamic>{
      'id': instance.id,
      'work_id': instance.workId,
      'user_id': instance.userId,
    };
