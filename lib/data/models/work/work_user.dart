import 'package:json_annotation/json_annotation.dart';
part 'work_user.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkUser {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'work_id')
  int? workId;
  @JsonKey(name: 'user_id')
  int? userId;

  WorkUser({
    required this.id,
    required this.workId,
    required this.userId,
  });

  factory WorkUser.fromJson(Map<String, dynamic> json) =>
      _$WorkUserFromJson(json);

  Map<String, dynamic> toJson() => _$WorkUserToJson(this);
}
