// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkComment _$WorkCommentFromJson(Map<String, dynamic> json) => WorkComment(
      commentId: json['id'] as int,
      userId: json['user_id'] as int,
      postId: json['work_id'] as int,
      content: json['content'] as String,
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkCommentToJson(WorkComment instance) =>
    <String, dynamic>{
      'id': instance.commentId,
      'user_id': instance.userId,
      'work_id': instance.postId,
      'content': instance.content,
      'user': instance.userModel.toJson(),
    };
