// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'work.g.dart';

@JsonSerializable(explicitToJson: true)
class Work {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'start_day')
  String? startDay;
  @JsonKey(name: 'end_day')
  String? endDay;
  @JsonKey(name: 'date_time')
  String? dateTime;
  @JsonKey(name: 'path')
  String? path;
  @JsonKey(name: 'status')
  int? status;

  Work(
      {required this.id,
      required this.name,
      required this.startDay,
      required this.endDay,
      required this.dateTime,
      required this.path,
      required this.status});

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);

  Map<String, dynamic> toJson() => _$WorkToJson(this);
}
