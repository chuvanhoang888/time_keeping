import 'package:json_annotation/json_annotation.dart';

part 'work_comments.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkComments {
  String commentId;
  String workId;

  String content;
  String userId;
  String userPhoto;
  String userName;
  String timeAgo;
  List<String> likes;

  WorkComments({
    required this.commentId,
    required this.workId,
    required this.content,
    required this.userId,
    required this.userPhoto,
    required this.userName,
    required this.timeAgo,
    required this.likes,
  });
  factory WorkComments.fromJson(Map<String, dynamic> json) =>
      _$WorkCommentsFromJson(json);
  Map<String, dynamic> toJson() => _$WorkCommentsToJson(this);
}
