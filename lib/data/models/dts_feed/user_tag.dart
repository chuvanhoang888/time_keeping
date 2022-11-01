import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_tag.g.dart';

@JsonSerializable(explicitToJson: true)
class UserTag {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'post_id')
  int? postId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'user')
  UserModel? user;

  UserTag(
      {required this.id,
      required this.postId,
      required this.userId,
      required this.user});

  factory UserTag.fromJson(Map<String, dynamic> json) =>
      _$UserTagFromJson(json);

  Map<String, dynamic> toJson() => _$UserTagToJson(this);
}
