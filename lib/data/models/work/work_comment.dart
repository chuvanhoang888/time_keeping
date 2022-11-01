import 'package:json_annotation/json_annotation.dart';

import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';

part 'work_comment.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkComment {
  @JsonKey(name: 'id')
  int commentId;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'work_id')
  int postId;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'user')
  UserModel userModel;

  WorkComment({
    required this.commentId,
    required this.userId,
    required this.postId,
    required this.content,
    required this.userModel,
  });
  factory WorkComment.fromJson(Map<String, dynamic> json) =>
      _$WorkCommentFromJson(json);
  Map<String, dynamic> toJson() => _$WorkCommentToJson(this);
}
