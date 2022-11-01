// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_ex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkModel _$WorkModelFromJson(Map<String, dynamic> json) => WorkModel(
      idWork: json['idWork'] as String,
      statusWork: json['statusWork'] as bool,
      title: json['title'] as String,
      request: json['request'] as String,
      progress: json['progress'] as String,
      time: json['time'] as String,
      startDay: json['startDay'] as String,
      endDay: json['endDay'] as String,
      userList: (json['userList'] as List<dynamic>)
          .map((e) => UserWork.fromJson(e as Map<String, dynamic>))
          .toList(),
      workRequest: (json['workRequest'] as List<dynamic>)
          .map((e) => WorkRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      fileAttachment: json['fileAttachment'] as String,
      imagesWork: (json['imagesWork'] as List<dynamic>)
          .map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkModelToJson(WorkModel instance) => <String, dynamic>{
      'idWork': instance.idWork,
      'statusWork': instance.statusWork,
      'title': instance.title,
      'request': instance.request,
      'progress': instance.progress,
      'time': instance.time,
      'startDay': instance.startDay,
      'endDay': instance.endDay,
      'userList': instance.userList.map((e) => e.toJson()).toList(),
      'workRequest': instance.workRequest.map((e) => e.toJson()).toList(),
      'fileAttachment': instance.fileAttachment,
      'imagesWork': instance.imagesWork.map((e) => e.toJson()).toList(),
    };
