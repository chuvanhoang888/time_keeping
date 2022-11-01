// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      name: json['username'] as String,
      email: json['email'] as String,
      position: json['position'] as String?,
      userRolePermission: json['role'] as int?,
      image: json['photo'] as String?,
      selected: json['selected'] as bool? ?? false,
      idWorkUser: json['idWorkUser'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.name,
      'email': instance.email,
      'position': instance.position,
      'role': instance.userRolePermission,
      'photo': instance.image,
      'selected': instance.selected,
      'idWorkUser': instance.idWorkUser,
    };
