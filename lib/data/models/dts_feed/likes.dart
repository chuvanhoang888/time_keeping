// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'likes.g.dart';

@JsonSerializable(explicitToJson: true)
class Likes {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'post_id')
  int? postID;
  Likes({
    required this.userId,
    required this.postID,
  });

  factory Likes.fromJson(Map<String, dynamic> json) => _$LikesFromJson(json);
  Map<String, dynamic> toJson() => _$LikesToJson(this);
}
