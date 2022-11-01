// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'permission.g.dart';

@JsonSerializable(explicitToJson: true)
class PermissonModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'time')
  String? time;
  @JsonKey(name: 'day')
  String? day;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'user')
  UserModel? userModel;
  @JsonKey(name: 'to_mail')
  String? toMail;

  PermissonModel({
    required this.id,
    required this.toMail,
    required this.type,
    required this.time,
    required this.day,
    required this.content,
  });
  factory PermissonModel.fromJson(Map<String, dynamic> json) =>
      _$PermissonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PermissonModelToJson(this);
}
