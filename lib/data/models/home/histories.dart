import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'histories.g.dart';

@JsonSerializable(explicitToJson: true)
class Histories {
  final int? id;
  String? content;
  UserModel? userModel;
  String? startTime;
  String? endTime;
  String? timeNow;

  Histories(
      {required this.id,
      required this.content,
      required this.userModel,
      required this.startTime,
      required this.endTime,
      required this.timeNow});

  factory Histories.fromJson(Map<String, dynamic> json) =>
      _$HistoriesFromJson(json);
  Map<String, dynamic> toJson() => _$HistoriesToJson(this);
}
