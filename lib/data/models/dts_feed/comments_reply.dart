// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';

part 'comments_reply.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentsReply {
  @JsonKey(name: 'id')
  int commentReplyId;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'comment_id')
  int commentId;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'user')
  UserModel userModel;

  CommentsReply({
    required this.commentReplyId,
    required this.userId,
    required this.commentId,
    required this.content,
    required this.userModel,
  });
  factory CommentsReply.fromJson(Map<String, dynamic> json) =>
      _$CommentsReplyFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsReplyToJson(this);
}
