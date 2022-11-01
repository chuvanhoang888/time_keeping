// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
part 'timekeeping_history.g.dart';

@JsonSerializable(explicitToJson: true)
class TimekeepingHistory {
  final String idTimekeeping;
  String timeCheck;
  String userName;
  String typeShift; // ca làm việc
  String startTime;
  String endTime;
  TimekeepingHistory({
    required this.idTimekeeping,
    required this.timeCheck,
    required this.userName,
    required this.typeShift,
    required this.startTime,
    required this.endTime,
  });
  factory TimekeepingHistory.fromJson(Map<String, dynamic> json) =>
      _$TimekeepingHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$TimekeepingHistoryToJson(this);
}
