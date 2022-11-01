// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsReply _$CommentsReplyFromJson(Map<String, dynamic> json) =>
    CommentsReply(
      commentReplyId: json['id'] as int,
      userId: json['user_id'] as int,
      commentId: json['comment_id'] as int,
      content: json['content'] as String,
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentsReplyToJson(CommentsReply instance) =>
    <String, dynamic>{
      'id': instance.commentReplyId,
      'user_id': instance.userId,
      'comment_id': instance.commentId,
      'content': instance.content,
      'user': instance.userModel.toJson(),
    };
