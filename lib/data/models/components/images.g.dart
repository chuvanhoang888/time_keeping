// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      id: json['id'] as int,
      urlPhoto: json['photo'] as String,
      postId: json['post_id'] as int,
      type: json['type'] as int,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'id': instance.id,
      'photo': instance.urlPhoto,
      'post_id': instance.postId,
      'type': instance.type,
    };
