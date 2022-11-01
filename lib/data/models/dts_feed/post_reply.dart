import 'package:app_cham_cong_option_2/data/models/dts_feed/comments_reply.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_reply.g.dart';

@JsonSerializable(explicitToJson: true)
class PostReply {
  List<CommentsReply> replies;
  int commentId;

  PostReply({required this.replies, required this.commentId});

  factory PostReply.fromJson(Map<String, dynamic> json) =>
      _$PostReplyFromJson(json);
  Map<String, dynamic> toJson() => _$PostReplyToJson(this);
}
