// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissonModel _$PermissonModelFromJson(Map<String, dynamic> json) =>
    PermissonModel(
      id: json['id'] as int?,
      toMail: json['to_mail'] as String?,
      type: json['type'] as String?,
      time: json['time'] as String?,
      day: json['day'] as String?,
      content: json['content'] as String?,
    )..userModel = json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$PermissonModelToJson(PermissonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'day': instance.day,
      'content': instance.content,
      'type': instance.type,
      'user': instance.userModel?.toJson(),
      'to_mail': instance.toMail,
    };
