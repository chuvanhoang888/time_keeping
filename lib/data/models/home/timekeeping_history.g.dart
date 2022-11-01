// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timekeeping_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimekeepingHistory _$TimekeepingHistoryFromJson(Map<String, dynamic> json) =>
    TimekeepingHistory(
      idTimekeeping: json['idTimekeeping'] as String,
      timeCheck: json['timeCheck'] as String,
      userName: json['userName'] as String,
      typeShift: json['typeShift'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$TimekeepingHistoryToJson(TimekeepingHistory instance) =>
    <String, dynamic>{
      'idTimekeeping': instance.idTimekeeping,
      'timeCheck': instance.timeCheck,
      'userName': instance.userName,
      'typeShift': instance.typeShift,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
