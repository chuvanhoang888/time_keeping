// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
part 'work_request.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkRequestModel {
  final String idWorkRequest;
  String content;
  bool statusWorkRequest;
  WorkRequestModel({
    required this.idWorkRequest,
    required this.content,
    this.statusWorkRequest = false,
  });

  factory WorkRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WorkRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkRequestModelToJson(this);
}
