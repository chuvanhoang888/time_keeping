// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Work _$WorkFromJson(Map<String, dynamic> json) => Work(
      id: json['id'] as int?,
      name: json['name'] as String?,
      startDay: json['start_day'] as String?,
      endDay: json['end_day'] as String?,
      dateTime: json['date_time'] as String?,
      path: json['path'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$WorkToJson(Work instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'start_day': instance.startDay,
      'end_day': instance.endDay,
      'date_time': instance.dateTime,
      'path': instance.path,
      'status': instance.status,
    };
