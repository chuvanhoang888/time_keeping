import 'package:json_annotation/json_annotation.dart';
part 'user_image.g.dart';

@JsonSerializable(explicitToJson: true)
class UserImage {
  String? path;
  int? state;

  UserImage({this.path, this.state = 0});

  factory UserImage.fromJson(Map<String, dynamic> json) =>
      _$UserImageFromJson(json);
  Map<String, dynamic> toJson() => _$UserImageToJson(this);
}
