import 'package:json_annotation/json_annotation.dart';
part 'notifications.g.dart';

@JsonSerializable(explicitToJson: true)
class Notifications {
  final int? id;
  final String? name;
  final String? content;
  final String? time;

  Notifications(
      {required this.id,
      required this.name,
      required this.content,
      required this.time});

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}
