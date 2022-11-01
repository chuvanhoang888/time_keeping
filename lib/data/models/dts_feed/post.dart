// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:app_cham_cong_option_2/data/models/components/images.dart';
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/likes.dart';
import 'package:app_cham_cong_option_2/data/models/dts_feed/user_tag.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Posts {
  @JsonKey(name: 'id')
  final int idPost;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'images')
  List<Images>? imagesPost;
  @JsonKey(name: 'user')
  UserModel userModel;
  @JsonKey(name: 'userTags')
  List<UserTag> userTag;
  @JsonKey(name: 'time_ago')
  String? timeAgo;
  @JsonKey(name: 'likeCount')
  int? likeCount;
  @JsonKey(name: 'commentCount')
  int? commentCount;
  @JsonKey(name: 'likes')
  List<Likes> likes;
  @JsonKey(name: 'view')
  int? view;
  @JsonKey(name: 'enable_comment')
  int? offComment;
  Posts({
    required this.idPost,
    required this.content,
    required this.imagesPost,
    required this.userModel,
    required this.userTag,
    required this.timeAgo,
    required this.likeCount,
    required this.commentCount,
    required this.likes,
    required this.view,
    this.offComment,
  });

  // getSelfLike() {
  //   if (likes.isNotEmpty) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  // bool getSelfLike() {
  //   return (likes != null && likes.isNotEmpty);
  // }

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
  Map<String, dynamic> toJson() => _$PostsToJson(this);
}
