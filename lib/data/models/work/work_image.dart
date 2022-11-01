import 'package:json_annotation/json_annotation.dart';
part 'work_image.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkImage {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'work_id')
  int? workId;
  String? path;
  @JsonKey(name: 'photo')
  String? images;
  int? state;

  WorkImage({this.id, this.workId, this.path, this.images, this.state = 0});

  factory WorkImage.fromJson(Map<String, dynamic> json) =>
      _$WorkImageFromJson(json);
  Map<String, dynamic> toJson() => _$WorkImageToJson(this);
}
