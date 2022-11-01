// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostReply _$PostReplyFromJson(Map<String, dynamic> json) => PostReply(
      replies: (json['replies'] as List<dynamic>)
          .map((e) => CommentsReply.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentId: json['commentId'] as int,
    );

Map<String, dynamic> _$PostReplyToJson(PostReply instance) => <String, dynamic>{
      'replies': instance.replies.map((e) => e.toJson()).toList(),
      'commentId': instance.commentId,
    };
