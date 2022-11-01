// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeComment _$LikeCommentFromJson(Map<String, dynamic> json) => LikeComment(
      userId: json['user_id'] as int?,
      commentID: json['comment_id'] as int?,
    );

Map<String, dynamic> _$LikeCommentToJson(LikeComment instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'comment_id': instance.commentID,
    };
