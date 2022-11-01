import 'package:json_annotation/json_annotation.dart';
part 'self_like.g.dart';

@JsonSerializable(explicitToJson: true)
class SelfLike {
  bool? selfLiked;

  SelfLike({required this.selfLiked});

  factory SelfLike.fromJson(Map<String, dynamic> json) =>
      _$SelfLikeFromJson(json);
  Map<String, dynamic> toJson() => _$SelfLikeToJson(this);
}
