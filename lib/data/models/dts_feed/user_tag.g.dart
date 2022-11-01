// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTag _$UserTagFromJson(Map<String, dynamic> json) => UserTag(
      id: json['id'] as int?,
      postId: json['post_id'] as int?,
      userId: json['user_id'] as int?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserTagToJson(UserTag instance) => <String, dynamic>{
      'id': instance.id,
      'post_id': instance.postId,
      'user_id': instance.userId,
      'user': instance.user?.toJson(),
    };
