// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'username')
  final String name;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'position')
  final String? position;
  @JsonKey(name: 'role')
  final int? userRolePermission;
  @JsonKey(name: 'photo')
  final String? image;
  bool? selected;
  int? idWorkUser;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.position,
      required this.userRolePermission,
      required this.image,
      this.selected = false,
      this.idWorkUser});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
