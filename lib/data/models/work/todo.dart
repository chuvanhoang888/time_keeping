// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable(explicitToJson: true)
class Todo {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'work_id')
  int? workId;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'status')
  int? status;

  Todo(
      {required this.id,
      required this.workId,
      required this.content,
      required this.status});

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
