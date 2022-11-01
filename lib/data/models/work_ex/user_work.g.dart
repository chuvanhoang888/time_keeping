// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWork _$UserWorkFromJson(Map<String, dynamic> json) => UserWork(
      name: json['name'] as String,
      email: json['email'] as String,
      photo: json['photo'] as String,
      selected: json['selected'] as bool? ?? false,
    );

Map<String, dynamic> _$UserWorkToJson(UserWork instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'photo': instance.photo,
      'selected': instance.selected,
    };
