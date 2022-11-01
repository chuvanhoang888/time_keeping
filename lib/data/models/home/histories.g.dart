// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'histories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Histories _$HistoriesFromJson(Map<String, dynamic> json) => Histories(
      id: json['id'] as int?,
      content: json['content'] as String?,
      userModel: json['userModel'] == null
          ? null
          : UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      timeNow: json['timeNow'] as String?,
    );

Map<String, dynamic> _$HistoriesToJson(Histories instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'userModel': instance.userModel?.toJson(),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'timeNow': instance.timeNow,
    };
