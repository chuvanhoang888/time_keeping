// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cham_cong_option_2/data/models/work_ex/user_work.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:app_cham_cong_option_2/data/models/components/images.dart';

import 'package:app_cham_cong_option_2/data/models/work_ex/work_request.dart';

part 'work_ex.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkModel {
  final String idWork;
  bool statusWork;
  String title;
  String request;
  String progress;
  String time;
  String startDay;
  String endDay;
  List<UserWork> userList;
  List<WorkRequestModel> workRequest;
  String fileAttachment;
  List<Images> imagesWork;
  WorkModel({
    required this.idWork,
    required this.statusWork,
    required this.title,
    required this.request,
    required this.progress,
    required this.time,
    required this.startDay,
    required this.endDay,
    required this.userList,
    required this.workRequest,
    required this.fileAttachment,
    required this.imagesWork,
  });
  //List<WorkComments> workComments;

  factory WorkModel.fromJson(Map<String, dynamic> json) =>
      _$WorkModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkModelToJson(this);
}
