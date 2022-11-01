// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkRequestModel _$WorkRequestModelFromJson(Map<String, dynamic> json) =>
    WorkRequestModel(
      idWorkRequest: json['idWorkRequest'] as String,
      content: json['content'] as String,
      statusWorkRequest: json['statusWorkRequest'] as bool? ?? false,
    );

Map<String, dynamic> _$WorkRequestModelToJson(WorkRequestModel instance) =>
    <String, dynamic>{
      'idWorkRequest': instance.idWorkRequest,
      'content': instance.content,
      'statusWorkRequest': instance.statusWorkRequest,
    };
