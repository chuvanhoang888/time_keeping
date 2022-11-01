// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'images.g.dart';

@JsonSerializable(explicitToJson: true)
class Images {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'photo')
  String urlPhoto;
  @JsonKey(name: 'post_id')
  int postId;
  @JsonKey(name: 'type')
  int type;
  Images({
    required this.id,
    required this.urlPhoto,
    required this.postId,
    required this.type,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
