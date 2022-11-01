// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Likes _$LikesFromJson(Map<String, dynamic> json) => Likes(
      userId: json['user_id'] as int?,
      postID: json['post_id'] as int?,
    );

Map<String, dynamic> _$LikesToJson(Likes instance) => <String, dynamic>{
      'user_id': instance.userId,
      'post_id': instance.postID,
    };
