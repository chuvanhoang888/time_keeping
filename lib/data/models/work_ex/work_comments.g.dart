// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkComments _$WorkCommentsFromJson(Map<String, dynamic> json) => WorkComments(
      commentId: json['commentId'] as String,
      workId: json['workId'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      userPhoto: json['userPhoto'] as String,
      userName: json['userName'] as String,
      timeAgo: json['timeAgo'] as String,
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WorkCommentsToJson(WorkComments instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'workId': instance.workId,
      'content': instance.content,
      'userId': instance.userId,
      'userPhoto': instance.userPhoto,
      'userName': instance.userName,
      'timeAgo': instance.timeAgo,
      'likes': instance.likes,
    };
