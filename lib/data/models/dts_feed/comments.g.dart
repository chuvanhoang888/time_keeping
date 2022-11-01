// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      commentId: json['id'] as int,
      userId: json['user_id'] as int,
      postId: json['post_id'] as int,
      content: json['content'] as String,
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      likes: (json['likes'] as List<dynamic>)
          .map((e) => LikeComment.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..likesCount = json['commentLikeCount'] as int?;

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'id': instance.commentId,
      'user_id': instance.userId,
      'post_id': instance.postId,
      'content': instance.content,
      'user': instance.userModel.toJson(),
      'likes': instance.likes.map((e) => e.toJson()).toList(),
      'commentLikeCount': instance.likesCount,
    };
