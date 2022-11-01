import 'package:json_annotation/json_annotation.dart';
part 'like_comment.g.dart';

@JsonSerializable(explicitToJson: true)
class LikeComment {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'comment_id')
  int? commentID;
  LikeComment({
    required this.userId,
    required this.commentID,
  });

  factory LikeComment.fromJson(Map<String, dynamic> json) =>
      _$LikeCommentFromJson(json);
  Map<String, dynamic> toJson() => _$LikeCommentToJson(this);
}
