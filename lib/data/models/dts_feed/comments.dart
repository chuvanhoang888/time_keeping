// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cham_cong_option_2/data/models/dts_feed/like_comment.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';

part 'comments.g.dart';

@JsonSerializable(explicitToJson: true)
class Comments {
  @JsonKey(name: 'id')
  int commentId;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'post_id')
  int postId;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'user')
  UserModel userModel;
  @JsonKey(name: 'likes')
  List<LikeComment> likes;
  @JsonKey(name: 'commentLikeCount')
  int? likesCount;
  // @JsonKey(name: 'comment_reply_count')
  // int commentReplyCount;

  Comments({
    required this.commentId,
    required this.userId,
    required this.postId,
    required this.content,
    required this.userModel,
    required this.likes,
    //required this.commentReplyCount,
  });
  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}
