// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(Map<String, dynamic> json) => Posts(
      idPost: json['id'] as int,
      content: json['content'] as String,
      imagesPost: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      userTag: (json['userTags'] as List<dynamic>)
          .map((e) => UserTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeAgo: json['time_ago'] as String?,
      likeCount: json['likeCount'] as int?,
      commentCount: json['commentCount'] as int?,
      likes: (json['likes'] as List<dynamic>)
          .map((e) => Likes.fromJson(e as Map<String, dynamic>))
          .toList(),
      view: json['view'] as int?,
      offComment: json['enable_comment'] as int?,
    );

Map<String, dynamic> _$PostsToJson(Posts instance) => <String, dynamic>{
      'id': instance.idPost,
      'content': instance.content,
      'images': instance.imagesPost?.map((e) => e.toJson()).toList(),
      'user': instance.userModel.toJson(),
      'userTags': instance.userTag.map((e) => e.toJson()).toList(),
      'time_ago': instance.timeAgo,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'likes': instance.likes.map((e) => e.toJson()).toList(),
      'view': instance.view,
      'enable_comment': instance.offComment,
    };
